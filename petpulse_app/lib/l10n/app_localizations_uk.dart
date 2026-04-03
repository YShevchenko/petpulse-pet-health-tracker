// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'PetPulse';

  @override
  String get addPet => 'Dodaty Tvarynku';

  @override
  String get editPet => 'Redahuvaty Tvarynku';

  @override
  String get deletePet => 'Vydalyty Tvarynku';

  @override
  String get petName => 'Imia Tvaryny';

  @override
  String get species => 'Vyd';

  @override
  String get breed => 'Poroda';

  @override
  String get birthday => 'Den Narodzhennia';

  @override
  String get photo => 'Foto';

  @override
  String get notes => 'Notatky';

  @override
  String get vaccinations => 'Vaktsyatsii';

  @override
  String get medications => 'Likuvannia';

  @override
  String get weight => 'Vaha';

  @override
  String get petPassport => 'Pasport Tvaryny';

  @override
  String get markAsGiven => 'Poznatyty yak Dano';

  @override
  String get dueToday => 'Zaplanvano na Sohodni';

  @override
  String get expired => 'Proterminovano';

  @override
  String expiresIn(int days) {
    return 'Splivae cherez $days dniv';
  }

  @override
  String expiredDaysAgo(int days) {
    return 'Proterminovano $days dniv tomu';
  }

  @override
  String get addVaccination => 'Dodaty Vaktsyatsiiu';

  @override
  String get editVaccination => 'Redahuvaty Vaktsyatsiiu';

  @override
  String get addMedication => 'Dodaty Likuvannia';

  @override
  String get editMedication => 'Redahuvaty Likuvannia';

  @override
  String get logWeight => 'Zapysaty Vahu';

  @override
  String get export => 'Eksportuvaty';

  @override
  String get share => 'Podilitysia';

  @override
  String get settings => 'Nalashtuvannia';

  @override
  String get save => 'Zberehty';

  @override
  String get cancel => 'Skasuavty';

  @override
  String get delete => 'Vydalyty';

  @override
  String get confirm => 'Pidtverdyty';

  @override
  String get overview => 'Ohliad';

  @override
  String get vaccinationName => 'Nazva Vaktsyny';

  @override
  String get dateAdministered => 'Data Vvedennia';

  @override
  String get expirationDate => 'Termin Dii';

  @override
  String get vetName => 'Imia Veteryanya';

  @override
  String get medicationName => 'Nazva Liku';

  @override
  String get dosage => 'Dozuvannia';

  @override
  String get frequency => 'Chastotnist';

  @override
  String get startDate => 'Data Pochatku';

  @override
  String get endDate => 'Data Kintsya';

  @override
  String get daily => 'Shchodnia';

  @override
  String get weekly => 'Shchotyzhnia';

  @override
  String get monthly => 'Shchomisiatsia';

  @override
  String get weightKg => 'Vaha (kh)';

  @override
  String get date => 'Data';

  @override
  String get noPets => 'Shche nemaie tvaryn. Dodaite pershu tvarynku!';

  @override
  String get noVaccinations => 'Nemaie vaktsyatsii.';

  @override
  String get noMedications => 'Nemaie likuvannia.';

  @override
  String get noWeightEntries => 'Shche nemaie zapysiv vahy.';

  @override
  String deleteConfirmTitle(String name) {
    return 'Vydalyty $name?';
  }

  @override
  String get deleteConfirmMessage => 'Tsiu diiu ne mozhna skasuavty.';

  @override
  String get premium => 'Premium';

  @override
  String get upgradeToPremium => 'Onovyty do Premium';

  @override
  String get premiumDescription =>
      'Bezmezhna kilkist tvaryn, eksport PDF pasporta, nahaduvannia pro liky';

  @override
  String get premiumPrice => '\$14.99 odnorazovo';

  @override
  String get restorePurchases => 'Vidnovyty Pokupky';

  @override
  String get purchaseSuccess => 'Pokupka uspishna!';

  @override
  String get purchaseError => 'Pokupka ne vdalasia. Sprobuite shche raz.';

  @override
  String get freeTierLimit =>
      'Bekoshtovnyi plan dozvoliaie 1 tvarynku. Onovit do Premium dlia bezmezhnoho.';

  @override
  String get premiumFeature => 'Tse Premium funktsiia.';

  @override
  String get weightTrend => 'Tendentsiia Vahy';

  @override
  String get generatePassport => 'Stvoryty Pasport';

  @override
  String get sharePassport => 'Podilitysia Pasportom';

  @override
  String get printPassport => 'Drukuvaty Pasport';

  @override
  String get petInformation => 'Informatsiia pro Tvaryny';

  @override
  String get currentMedications => 'Potochni Liky';

  @override
  String get latestWeight => 'Ostannia Vaha';

  @override
  String get generatedBy => 'Stvnoreno PetPulse';

  @override
  String get dog => 'Sobaka';

  @override
  String get cat => 'Kit';

  @override
  String get bird => 'Ptakh';

  @override
  String get rabbit => 'Krolik';

  @override
  String get other => 'Inshe';

  @override
  String get selectSpecies => 'Obraty Vyd';

  @override
  String get selectDate => 'Obraty Datu';

  @override
  String get selectFrequency => 'Obraty Chastotnist';

  @override
  String get fieldRequired => 'Tse pole oboviakove';

  @override
  String get age => 'Vik';

  @override
  String years(int count) {
    return '$count rokiv';
  }

  @override
  String months(int count) {
    return '$count misiatsiv';
  }

  @override
  String get weightUnit => 'kh';

  @override
  String get medicationReminder => 'Nahaduvannia pro Liky';

  @override
  String medicationReminderBody(String petName, String medicationName) {
    return 'Chas daty $petName yikh $medicationName';
  }

  @override
  String get vaccinationExpiring => 'Vaktsyatsiia Splivae';

  @override
  String vaccinationExpiringBody(
    String petName,
    String vaccinationName,
    int days,
  ) {
    return 'Vaktsyatsiia $vaccinationName tvaryny $petName splivae cherez $days dniv';
  }

  @override
  String vaccinationExpiredBody(String petName, String vaccinationName) {
    return 'Vaktsyatsiia $vaccinationName tvaryny $petName proterminovana!';
  }

  @override
  String get markedAsGiven => 'Poznacheno yak dano';

  @override
  String get allPets => 'Vsi Tvaryny';

  @override
  String get tapToAdd => 'Natysnitdlia dodavannia pershoi tvaryny';

  @override
  String get choosePhoto => 'Obraty Foto';

  @override
  String get takePhoto => 'Zrobyty Foto';

  @override
  String get removePhoto => 'Vydalyty Foto';

  @override
  String get aboutApp => 'Pro PetPulse';

  @override
  String get aboutDescription =>
      'PetPulse dopomahaie vam vidstezhuvaty zdorovia, vaktsyatsii ta liky vashoi tvaryny v odnomu mistsi.';

  @override
  String get version => 'Versiia';

  @override
  String get publisher => 'Heldig Lab';

  @override
  String get microchipId => 'ID Mikrochypa';

  @override
  String get dueMedications => 'Navchalni Liky';

  @override
  String get upcomingVaccinations => 'Nablyzhenni Vaktsyatsii';

  @override
  String get freeMedicationLimit =>
      'Bezkoshtovna versiia dozvoliaie 3 liky. Onovit do Premium dlia nelimytovanykh.';

  @override
  String get weightLbs => 'Vaha (funt)';
}
