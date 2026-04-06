import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'domain/services/notification_service.dart';
import 'presentation/providers/providers.dart';
import 'services/ad_service.dart';
import 'services/consent_service.dart';
import 'services/iap_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  // Lock to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize services
  await _initializeServices();

  // Create container so we can wire IAP → isPremiumProvider
  final container = ProviderContainer();
  _wireIapToPremiumProvider(container);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const PetPulseApp(),
    ),
  );
}

/// Sync IapService premium state into the Riverpod isPremiumProvider.
void _wireIapToPremiumProvider(ProviderContainer container) {
  final iap = IapService();

  // Seed with current value (covers restored purchases during init)
  container.read(isPremiumProvider.notifier).state = iap.isPremium;

  // Keep in sync as new purchases come in
  iap.premiumStream.listen((isPremium) {
    container.read(isPremiumProvider.notifier).state = isPremium;
  });
}

Future<void> _initializeServices() async {
  // Initialize notifications
  await NotificationService().initialize();
  await NotificationService().requestPermission();

  // Initialize ads
  await AdService().initialize();
  await AdService().preloadInterstitial();

  // Initialize IAP
  await IapService().initialize();

  // Request ATT (iOS)
  await ConsentService().requestTrackingPermission();

  // Sync premium status from IAP to AdService
  final iap = IapService();
  AdService().isPremium = iap.isPremium;
  iap.premiumStream.listen((isPremium) {
    AdService().isPremium = isPremium;
  });
}
