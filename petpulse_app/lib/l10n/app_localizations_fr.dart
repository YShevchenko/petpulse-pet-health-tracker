// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'PetPulse';

  @override
  String get addPet => 'Ajouter un animal';

  @override
  String get editPet => 'Modifier l\'animal';

  @override
  String get deletePet => 'Supprimer l\'animal';

  @override
  String get petName => 'Nom de l\'animal';

  @override
  String get species => 'Espèce';

  @override
  String get breed => 'Race';

  @override
  String get birthday => 'Date de naissance';

  @override
  String get photo => 'Photo';

  @override
  String get notes => 'Notes';

  @override
  String get vaccinations => 'Vaccinations';

  @override
  String get medications => 'Médicaments';

  @override
  String get weight => 'Poids';

  @override
  String get petPassport => 'Passeport de l\'animal';

  @override
  String get markAsGiven => 'Marquer comme donné';

  @override
  String get dueToday => 'Dû aujourd\'hui';

  @override
  String get expired => 'Expiré';

  @override
  String expiresIn(int days) {
    return 'Expire dans $days jours';
  }

  @override
  String expiredDaysAgo(int days) {
    return 'Expiré il y a $days jours';
  }

  @override
  String get addVaccination => 'Ajouter une vaccination';

  @override
  String get editVaccination => 'Modifier la vaccination';

  @override
  String get addMedication => 'Ajouter un médicament';

  @override
  String get editMedication => 'Modifier le médicament';

  @override
  String get logWeight => 'Enregistrer le poids';

  @override
  String get export => 'Exporter';

  @override
  String get share => 'Partager';

  @override
  String get settings => 'Paramètres';

  @override
  String get save => 'Enregistrer';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get confirm => 'Confirmer';

  @override
  String get overview => 'Aperçu';

  @override
  String get vaccinationName => 'Nom de la vaccination';

  @override
  String get dateAdministered => 'Date d\'administration';

  @override
  String get expirationDate => 'Date d\'expiration';

  @override
  String get vetName => 'Nom du vétérinaire';

  @override
  String get medicationName => 'Nom du médicament';

  @override
  String get dosage => 'Dosage';

  @override
  String get frequency => 'Fréquence';

  @override
  String get startDate => 'Date de début';

  @override
  String get endDate => 'Date de fin';

  @override
  String get daily => 'Quotidien';

  @override
  String get weekly => 'Hebdomadaire';

  @override
  String get monthly => 'Mensuel';

  @override
  String get weightKg => 'Poids (kg)';

  @override
  String get date => 'Date';

  @override
  String get noPets => 'Aucun animal. Ajoutez votre premier animal !';

  @override
  String get noVaccinations => 'Aucune vaccination enregistrée.';

  @override
  String get noMedications => 'Aucun médicament enregistré.';

  @override
  String get noWeightEntries => 'Aucune entrée de poids.';

  @override
  String deleteConfirmTitle(String name) {
    return 'Supprimer $name ?';
  }

  @override
  String get deleteConfirmMessage => 'Cette action est irréversible.';

  @override
  String get premium => 'Premium';

  @override
  String get upgradeToPremium => 'Passer à Premium';

  @override
  String get premiumDescription =>
      'Animaux illimités, export de passeport PDF, rappels de médicaments';

  @override
  String get premiumPrice => '14,99 € une fois';

  @override
  String get restorePurchases => 'Restaurer les achats';

  @override
  String get purchaseSuccess => 'Achat réussi !';

  @override
  String get purchaseError => 'Échec de l\'achat. Veuillez réessayer.';

  @override
  String get freeTierLimit =>
      'La version gratuite permet 1 animal. Passez à Premium pour un nombre illimité.';

  @override
  String get premiumFeature => 'Ceci est une fonctionnalité Premium.';

  @override
  String get weightTrend => 'Tendance de poids';

  @override
  String get generatePassport => 'Générer le passeport';

  @override
  String get sharePassport => 'Partager le passeport';

  @override
  String get printPassport => 'Imprimer le passeport';

  @override
  String get petInformation => 'Informations sur l\'animal';

  @override
  String get currentMedications => 'Médicaments actuels';

  @override
  String get latestWeight => 'Dernier poids';

  @override
  String get generatedBy => 'Généré par PetPulse';

  @override
  String get dog => 'Chien';

  @override
  String get cat => 'Chat';

  @override
  String get bird => 'Oiseau';

  @override
  String get rabbit => 'Lapin';

  @override
  String get other => 'Autre';

  @override
  String get selectSpecies => 'Sélectionner l\'espèce';

  @override
  String get selectDate => 'Sélectionner la date';

  @override
  String get selectFrequency => 'Sélectionner la fréquence';

  @override
  String get fieldRequired => 'Ce champ est obligatoire';

  @override
  String get age => 'Âge';

  @override
  String years(int count) {
    return '$count ans';
  }

  @override
  String months(int count) {
    return '$count mois';
  }

  @override
  String get weightUnit => 'kg';

  @override
  String get medicationReminder => 'Rappel de médicament';

  @override
  String medicationReminderBody(String petName, String medicationName) {
    return 'Il est temps de donner à $petName son $medicationName';
  }

  @override
  String get vaccinationExpiring => 'Vaccination bientôt expirée';

  @override
  String vaccinationExpiringBody(
    String petName,
    String vaccinationName,
    int days,
  ) {
    return 'La vaccination $vaccinationName de $petName expire dans $days jours';
  }

  @override
  String vaccinationExpiredBody(String petName, String vaccinationName) {
    return 'La vaccination $vaccinationName de $petName a expiré !';
  }

  @override
  String get markedAsGiven => 'Marqué comme donné';

  @override
  String get allPets => 'Tous les animaux';

  @override
  String get tapToAdd => 'Appuyez sur + pour ajouter votre premier animal';

  @override
  String get choosePhoto => 'Choisir une photo';

  @override
  String get takePhoto => 'Prendre une photo';

  @override
  String get removePhoto => 'Supprimer la photo';

  @override
  String get aboutApp => 'À propos de PetPulse';

  @override
  String get aboutDescription =>
      'PetPulse vous aide à suivre les dossiers de santé, les vaccinations et les médicaments de votre animal au même endroit.';

  @override
  String get version => 'Version';

  @override
  String get publisher => 'Heldig Lab';

  @override
  String get microchipId => 'ID de puce électronique';

  @override
  String get dueMedications => 'Médicaments dus';

  @override
  String get upcomingVaccinations => 'Vaccinations à venir';

  @override
  String get freeMedicationLimit =>
      'La version gratuite permet 3 médicaments. Passez à Premium pour un nombre illimité.';

  @override
  String get weightLbs => 'Poids (lbs)';
}
