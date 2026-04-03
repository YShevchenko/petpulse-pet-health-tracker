// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'PetPulse';

  @override
  String get addPet => 'Haustier hinzufuegen';

  @override
  String get editPet => 'Haustier bearbeiten';

  @override
  String get deletePet => 'Haustier loeschen';

  @override
  String get petName => 'Name des Haustiers';

  @override
  String get species => 'Tierart';

  @override
  String get breed => 'Rasse';

  @override
  String get birthday => 'Geburtstag';

  @override
  String get photo => 'Foto';

  @override
  String get notes => 'Notizen';

  @override
  String get vaccinations => 'Impfungen';

  @override
  String get medications => 'Medikamente';

  @override
  String get weight => 'Gewicht';

  @override
  String get petPassport => 'Haustierpass';

  @override
  String get markAsGiven => 'Als gegeben markieren';

  @override
  String get dueToday => 'Heute faellig';

  @override
  String get expired => 'Abgelaufen';

  @override
  String expiresIn(int days) {
    return 'Laeuft in $days Tagen ab';
  }

  @override
  String expiredDaysAgo(int days) {
    return 'Vor $days Tagen abgelaufen';
  }

  @override
  String get addVaccination => 'Impfung hinzufuegen';

  @override
  String get editVaccination => 'Impfung bearbeiten';

  @override
  String get addMedication => 'Medikament hinzufuegen';

  @override
  String get editMedication => 'Medikament bearbeiten';

  @override
  String get logWeight => 'Gewicht erfassen';

  @override
  String get export => 'Exportieren';

  @override
  String get share => 'Teilen';

  @override
  String get settings => 'Einstellungen';

  @override
  String get save => 'Speichern';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Loeschen';

  @override
  String get confirm => 'Bestaetigen';

  @override
  String get overview => 'Uebersicht';

  @override
  String get vaccinationName => 'Impfungsname';

  @override
  String get dateAdministered => 'Verabreichungsdatum';

  @override
  String get expirationDate => 'Ablaufdatum';

  @override
  String get vetName => 'Tierarztname';

  @override
  String get medicationName => 'Medikamentenname';

  @override
  String get dosage => 'Dosierung';

  @override
  String get frequency => 'Haeufigkeit';

  @override
  String get startDate => 'Startdatum';

  @override
  String get endDate => 'Enddatum';

  @override
  String get daily => 'Taeglich';

  @override
  String get weekly => 'Woechentlich';

  @override
  String get monthly => 'Monatlich';

  @override
  String get weightKg => 'Gewicht (kg)';

  @override
  String get date => 'Datum';

  @override
  String get noPets => 'Noch keine Haustiere. Fuegen Sie Ihr erstes hinzu!';

  @override
  String get noVaccinations => 'Keine Impfungen erfasst.';

  @override
  String get noMedications => 'Keine Medikamente erfasst.';

  @override
  String get noWeightEntries => 'Noch keine Gewichtseintraege.';

  @override
  String deleteConfirmTitle(String name) {
    return '$name loeschen?';
  }

  @override
  String get deleteConfirmMessage =>
      'Diese Aktion kann nicht rueckgaengig gemacht werden.';

  @override
  String get premium => 'Premium';

  @override
  String get upgradeToPremium => 'Auf Premium upgraden';

  @override
  String get premiumDescription =>
      'Unbegrenzte Haustiere, PDF-Pass-Export, Medikamentenerinnerungen';

  @override
  String get premiumPrice => '14,99 \$ einmalig';

  @override
  String get restorePurchases => 'Kaeufe wiederherstellen';

  @override
  String get purchaseSuccess => 'Kauf erfolgreich!';

  @override
  String get purchaseError =>
      'Kauf fehlgeschlagen. Bitte versuchen Sie es erneut.';

  @override
  String get freeTierLimit =>
      'Die kostenlose Version erlaubt 1 Haustier. Upgraden Sie fuer unbegrenzte Haustiere.';

  @override
  String get premiumFeature => 'Dies ist eine Premium-Funktion.';

  @override
  String get weightTrend => 'Gewichtsverlauf';

  @override
  String get generatePassport => 'Pass erstellen';

  @override
  String get sharePassport => 'Pass teilen';

  @override
  String get printPassport => 'Pass drucken';

  @override
  String get petInformation => 'Haustierinformationen';

  @override
  String get currentMedications => 'Aktuelle Medikamente';

  @override
  String get latestWeight => 'Aktuelles Gewicht';

  @override
  String get generatedBy => 'Erstellt mit PetPulse';

  @override
  String get dog => 'Hund';

  @override
  String get cat => 'Katze';

  @override
  String get bird => 'Vogel';

  @override
  String get rabbit => 'Kaninchen';

  @override
  String get other => 'Andere';

  @override
  String get selectSpecies => 'Tierart waehlen';

  @override
  String get selectDate => 'Datum waehlen';

  @override
  String get selectFrequency => 'Haeufigkeit waehlen';

  @override
  String get fieldRequired => 'Dieses Feld ist erforderlich';

  @override
  String get age => 'Alter';

  @override
  String years(int count) {
    return '$count Jahre';
  }

  @override
  String months(int count) {
    return '$count Monate';
  }

  @override
  String get weightUnit => 'kg';

  @override
  String get medicationReminder => 'Medikamentenerinnerung';

  @override
  String medicationReminderBody(String petName, String medicationName) {
    return 'Zeit, $petName ihr $medicationName zu geben';
  }

  @override
  String get vaccinationExpiring => 'Impfung laeuft ab';

  @override
  String vaccinationExpiringBody(
    String petName,
    String vaccinationName,
    int days,
  ) {
    return '${petName}s $vaccinationName laeuft in $days Tagen ab';
  }

  @override
  String vaccinationExpiredBody(String petName, String vaccinationName) {
    return '${petName}s $vaccinationName ist abgelaufen!';
  }

  @override
  String get markedAsGiven => 'Als gegeben markiert';

  @override
  String get allPets => 'Alle Haustiere';

  @override
  String get tapToAdd => 'Tippen Sie +, um Ihr erstes Haustier hinzuzufuegen';

  @override
  String get choosePhoto => 'Foto waehlen';

  @override
  String get takePhoto => 'Foto aufnehmen';

  @override
  String get removePhoto => 'Foto entfernen';

  @override
  String get aboutApp => 'Ueber PetPulse';

  @override
  String get aboutDescription =>
      'PetPulse hilft Ihnen, die Gesundheitsakten, Impfungen und Medikamente Ihres Haustiers an einem Ort zu verwalten.';

  @override
  String get version => 'Version';

  @override
  String get publisher => 'Heldig Lab';

  @override
  String get microchipId => 'Mikrochip-ID';

  @override
  String get dueMedications => 'Faellige Medikamente';

  @override
  String get upcomingVaccinations => 'Bevorstehende Impfungen';

  @override
  String get freeMedicationLimit =>
      'Kostenlose Version erlaubt 3 Medikamente. Upgrade auf Premium fuer unbegrenzte Anzahl.';

  @override
  String get weightLbs => 'Gewicht (lbs)';
}
