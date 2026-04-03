# PetPulse Test Plan

**Document:** TEST-PLAN.md  

## 1. Strategy
The primary risks are **Missed Reminders** and **PDF Generation Failures**.

## 2. Testing Tiers
- **Integration Tests:** Ensure `expo-notifications` correctly schedules triggers across day boundaries. Ensure `expo-print` successfully converts SQLite datasets into valid HTML structures.
- **E2E Tests:** End-to-end flow of adding a Pet, adding a Medication, marking it given, and rendering the PDF.
- **Manual QA:** 
  - Schedule a medication reminder for 2 minutes from now. Force-close the app. Verify the OS delivers the push notification.