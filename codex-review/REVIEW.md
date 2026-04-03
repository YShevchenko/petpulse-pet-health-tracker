# Codex Review — 2026-04-03

## Documentation

- **Concept:** PetPulse is a privacy-first, offline digital pet passport for iOS and Android. Users track vaccinations, recurring medications, and weight for their pets. A one-time $14.99 IAP unlocks multiple pet profiles, unlimited medication reminders, and PDF passport export.
- **Spec divergence:** `SPEC.md` and `ARCHITECTURE.md` describe a React Native / Expo stack with RevenueCat for IAP and Zustand for state. The actual codebase is Flutter (Dart 3.11, `pubspec.yaml`), using `flutter_riverpod` for state, `sqflite` for local storage, the `in_app_purchase` plugin for purchases, and `flutter_local_notifications` for reminders. The docs need a full rewrite to match the implemented technology stack.
- **Marketing:** `MARKETING.md` is a half-page outline — it names Pinterest/Instagram as primary ad platforms and prices the IAP at $14.99 in US/UK/AUS, but provides no budgets, CPI/LTV targets, creative test hypotheses, or retention benchmarks. Not actionable for spending.
- **Test plan:** `TEST-PLAN.md` identifies the two critical risk areas (missed reminders and PDF generation failures) and proposes integration, E2E, and manual QA tiers, but contains no automation instructions, tooling choices, or CI integration details.
- **Test cases:** `TEST-CASES.md` is thorough — 14 detailed manual test cases covering pet profiles, vaccination status logic (green/yellow/red), medication scheduling and discontinuation, weight logging, PDF passport generation, premium gating, JSON export/import, data deletion, and notification permission handling.
- **Architecture & schema:** `ARCHITECTURE.md` documents the SQLite schema in detail (6 tables with indexes). The implemented schema in `app_database.dart` is close but simpler: 4 tables (`pets`, `vaccinations`, `medications`, `weight_entries`) — notably missing are `medication_logs`, `settings`, and `medication_logs.given_at` from the spec. The `medications` table uses a `last_given TEXT` column instead.

## Code & Monetization

- **Code root:** `petpulse_app/` is a Flutter project. Clean layered architecture: `domain/` (models + repository interfaces + services), `data/` (SQLite repository implementations + database), `presentation/` (Riverpod providers, screens, widgets), `services/` (IAP, ads, ATT consent), `l10n/` (EN, ES, DE, UK localizations).
- **Screens (8):** `home_screen`, `pet_detail_screen`, `add_pet_screen`, `add_vaccination_screen`, `add_medication_screen`, `weight_log_screen`, `pet_passport_screen`, `settings_screen`.
- **Widgets (6):** `pet_card`, `vaccination_card`, `medication_card`, `expiry_badge`, `weight_chart` (using `fl_chart`), `species_picker`.
- **IAP service:** `iap_service.dart` uses `in_app_purchase` (not RevenueCat as documented in `ARCHITECTURE.md`). It buys a non-consumable (`com.heldiglab.petpulse.premium`), listens to the purchase stream, and completes purchases on all terminal states. No server-side receipt validation — premium status is determined entirely by the platform purchase stream. No persistent storage of premium status (no SharedPreferences or SQLite flag); on every app launch, `restorePurchases()` is called to re-derive premium state from the store. If the store is unreachable at launch, the user silently loses premium access until connectivity resumes.
- **Ad service:** `ad_service.dart` uses `google_mobile_ads` with banner and interstitial ads. Interstitials fire every 5 screen navigations (configurable via `AppConstants.interstitialFrequency`). All ad unit IDs in `constants.dart` are Google test IDs — production IDs are not yet set.
- **Consent service:** `consent_service.dart` handles iOS ATT prompts via `app_tracking_transparency`. Non-iOS platforms default to tracking allowed.
- **Notification service:** `notification_service.dart` uses `flutter_local_notifications` with timezone-aware scheduling. Supports daily/weekly/monthly medication reminders and vaccination expiry alerts at 30-day, 7-day, and day-of thresholds. Creates separate Android notification channels for medications and vaccinations. Notification tap handler (`_onNotificationResponse`) is stubbed but does not navigate anywhere yet.
- **PDF service:** `pdf_service.dart` uses the `pdf` package (not `expo-print` as documented). Generates a formatted A4 Pet Passport with pet info, photo, vaccination table, and medication table. Fully functional, including footer branding ("Heldig Lab").
- **Premium sync:** `main.dart` bridges `IapService.premiumStream` to `AdService.isPremium` so ads stop when the user goes premium. However, the Riverpod `isPremiumProvider` in `providers.dart` is a standalone `StateProvider<bool>` initialized to `false` and is never connected to the `IapService` stream — meaning the UI premium gate and the ad-suppression logic could be out of sync.

## Stability & Revenue Risks

1. **Premium state not persisted.** `IapService` calls `restorePurchases()` on every launch to re-derive premium status. If the device is offline or the store is slow, the user sees free-tier limits despite having paid. There is no local cache (SharedPreferences, SQLite, or similar) to bridge this gap.
2. **Riverpod premium provider disconnected from IAP.** `isPremiumProvider` is a plain `StateProvider<bool>` that is never updated by `IapService.premiumStream`. The settings screen and any premium gates in the UI that read `isPremiumProvider` will always show `false` unless this wiring is added.
3. **No server-side receipt validation.** The IAP flow trusts the platform purchase stream entirely. Refunds, chargebacks, and fraudulent purchases are invisible. For a $14.99 non-consumable this is acceptable short-term but blocks revenue forecasting at scale.
4. **Test ad unit IDs in production constants.** All six AdMob IDs in `constants.dart` are Google's published test IDs (`ca-app-pub-3940256099942544/...`). A production build with these IDs will show test ads and earn zero revenue.
5. **No JSON export/import in code.** `TEST-CASES.md` (TC-301, TC-111, TC-112, TC-113) specifies JSON export/import and "Delete All Data" functionality. The settings screen has no export, import, or data deletion buttons — these features are specified but not implemented.
6. **No `medication_logs` table.** The spec schema includes a `medication_logs` table to track individual dose-given events. The implementation uses a `last_given TEXT` column on the `medications` table instead, which only stores the most recent dose timestamp, losing dose history.
7. **Notification tap handler is a no-op.** `_onNotificationResponse` has a comment about navigation but no implementation. Tapping a medication or vaccination notification does nothing.
8. **Marketing doc is not actionable for spending.** No budgets, no CPI/LTV targets, no A/B creative plans, no retention metrics. Cannot run paid UA campaigns from this document.
9. **Spec/code technology mismatch.** All documentation references React Native, Expo, Zustand, RevenueCat, and expo-sqlite. The actual app is Flutter with Riverpod, sqflite, in_app_purchase, and the dart `pdf` package. Any reviewer or new contributor reading the docs will be misled.

## Next Steps

1. **Fix the premium state wiring.** Connect `IapService.premiumStream` to the Riverpod `isPremiumProvider` (e.g., via a `ProviderContainer` listener in `main.dart` or a dedicated `StreamProvider`). Also persist premium status to SQLite or SharedPreferences so it survives offline launches.
2. **Replace test ad unit IDs.** Create production AdMob ad units and update `constants.dart` before any release build.
3. **Implement JSON export/import and "Delete All Data."** These are specified in TEST-CASES.md (TC-301, TC-111 through TC-113) and referenced in the UI-UX-SPEC settings screen but are missing from `settings_screen.dart`.
4. **Implement notification tap navigation.** Wire `_onNotificationResponse` to parse the payload (`medication:petId:medicationId` / `vaccination:petId:vaccinationId`) and navigate to the relevant detail screen.
5. **Rewrite documentation to match Flutter.** Update `SPEC.md`, `ARCHITECTURE.md`, and any references to React Native / Expo / RevenueCat / Zustand to reflect the actual Flutter / Riverpod / sqflite / in_app_purchase stack.
6. **Expand `MARKETING.md`** with explicit budgets, CPI/LTV thresholds, creative test plans, and retention metrics so UA spending can be tracked and optimized.
7. **Add integration/widget tests for critical paths.** The existing 6 test files cover model serialization, PDF generation, and expiry badge logic. Missing: repository tests, notification scheduling tests, IAP state tests, and widget tests for screens (especially the premium paywall gate).
8. **Consider adding `medication_logs` table** to preserve full dose history rather than only the last-given timestamp, which is needed for the "Mark as Given" audit trail referenced in the spec and test cases.
