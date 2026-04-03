import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/app_database.dart';
import '../../data/repositories/sqlite_medication_repository.dart';
import '../../data/repositories/sqlite_pet_repository.dart';
import '../../data/repositories/sqlite_vaccination_repository.dart';
import '../../data/repositories/sqlite_weight_repository.dart';
import '../../domain/models/medication.dart';
import '../../domain/models/pet.dart';
import '../../domain/models/vaccination.dart';
import '../../domain/models/weight_entry.dart';
import '../../domain/repositories/medication_repository.dart';
import '../../domain/repositories/pet_repository.dart';
import '../../domain/repositories/vaccination_repository.dart';
import '../../domain/repositories/weight_repository.dart';
import '../../domain/services/notification_service.dart';
import '../../services/ad_service.dart';
import '../../services/iap_service.dart';
import 'medication_notifier.dart';
import 'pet_notifier.dart';
import 'vaccination_notifier.dart';
import 'weight_notifier.dart';

// Database
final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

// Repositories
final petRepositoryProvider = Provider<PetRepository>((ref) {
  return SqlitePetRepository(ref.read(appDatabaseProvider));
});

final vaccinationRepositoryProvider = Provider<VaccinationRepository>((ref) {
  return SqliteVaccinationRepository(ref.read(appDatabaseProvider));
});

final medicationRepositoryProvider = Provider<MedicationRepository>((ref) {
  return SqliteMedicationRepository(ref.read(appDatabaseProvider));
});

final weightRepositoryProvider = Provider<WeightRepository>((ref) {
  return SqliteWeightRepository(ref.read(appDatabaseProvider));
});

// Services
final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

final adServiceProvider = Provider<AdService>((ref) {
  return AdService();
});

final iapServiceProvider = Provider<IapService>((ref) {
  return IapService();
});

// Premium state
final isPremiumProvider = StateProvider<bool>((ref) => false);

// Notifiers
final petNotifierProvider =
    StateNotifierProvider<PetNotifier, AsyncValue<List<Pet>>>((ref) {
  return PetNotifier(ref.read(petRepositoryProvider));
});

final vaccinationNotifierProvider = StateNotifierProvider.family<
    VaccinationNotifier, AsyncValue<List<Vaccination>>, String>(
  (ref, petId) {
    return VaccinationNotifier(
      ref.read(vaccinationRepositoryProvider),
      ref.read(notificationServiceProvider),
      petId,
    );
  },
);

final medicationNotifierProvider = StateNotifierProvider.family<
    MedicationNotifier, AsyncValue<List<Medication>>, String>(
  (ref, petId) {
    return MedicationNotifier(
      ref.read(medicationRepositoryProvider),
      ref.read(notificationServiceProvider),
      petId,
    );
  },
);

final weightNotifierProvider = StateNotifierProvider.family<WeightNotifier,
    AsyncValue<List<WeightEntry>>, String>(
  (ref, petId) {
    return WeightNotifier(
      ref.read(weightRepositoryProvider),
      petId,
    );
  },
);
