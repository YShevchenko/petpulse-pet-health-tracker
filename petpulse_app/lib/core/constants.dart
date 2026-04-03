/// App-wide constants for PetPulse.
class AppConstants {
  AppConstants._();

  // App info
  static const String appName = 'PetPulse';
  static const String publisher = 'Heldig Lab';
  static const String contactEmail = 'heldig.lab@pm.me';
  static const String appVersion = '1.0.1';

  // IAP
  static const String premiumProductId = 'com.heldiglab.petpulse.premium';
  static const double premiumPrice = 14.99;

  // Free tier limits
  static const int freeTierMaxPets = 1;

  // Ads
  static const int interstitialFrequency = 5; // every N screen navigations

  // AdMob IDs (test IDs — replace with real ones for production)
  static const String adMobAndroidAppId =
      'ca-app-pub-3940256099942544~3347511713';
  static const String adMobIosAppId =
      'ca-app-pub-3940256099942544~1458002511';
  static const String bannerAdUnitIdAndroid =
      'ca-app-pub-3940256099942544/6300978111';
  static const String bannerAdUnitIdIos =
      'ca-app-pub-3940256099942544/2934735716';
  static const String interstitialAdUnitIdAndroid =
      'ca-app-pub-3940256099942544/1033173712';
  static const String interstitialAdUnitIdIos =
      'ca-app-pub-3940256099942544/4411468910';

  // Notification channels
  static const String medicationChannelId = 'medication_reminders';
  static const String medicationChannelName = 'Medication Reminders';
  static const String medicationChannelDesc =
      'Reminders for pet medication schedules';
  static const String vaccinationChannelId = 'vaccination_alerts';
  static const String vaccinationChannelName = 'Vaccination Alerts';
  static const String vaccinationChannelDesc =
      'Alerts for upcoming vaccination expirations';

  // Vaccination expiry alert thresholds (days before expiration)
  static const int expiryAlertThreshold30 = 30;
  static const int expiryAlertThreshold7 = 7;
  static const int expiryAlertThreshold0 = 0;

  // Expiry badge color thresholds
  static const int expiryGreenThreshold = 30; // > 30 days = green
  static const int expiryYellowThreshold = 7; // 7-30 days = yellow/amber

  // Free tier medication limit
  static const int freeTierMaxMedications = 1;

  // Database
  static const String databaseName = 'petpulse.db';
  static const int databaseVersion = 2;

  // Species list
  static const List<String> speciesList = [
    'dog',
    'cat',
    'bird',
    'rabbit',
    'other',
  ];

  // Frequency options
  static const List<String> frequencyOptions = [
    'daily',
    'weekly',
    'monthly',
  ];
}
