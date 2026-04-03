import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/medication.dart';
import '../../domain/repositories/medication_repository.dart';
import '../../domain/services/notification_service.dart';

class MedicationNotifier extends StateNotifier<AsyncValue<List<Medication>>> {
  final MedicationRepository _repository;
  final NotificationService _notificationService;
  final String petId;

  MedicationNotifier(this._repository, this._notificationService, this.petId)
      : super(const AsyncValue.loading()) {
    loadMedications();
  }

  Future<void> loadMedications() async {
    state = const AsyncValue.loading();
    try {
      final medications = await _repository.getMedicationsForPet(petId);
      state = AsyncValue.data(medications);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addMedication(
      Medication medication, String petName) async {
    try {
      await _repository.insertMedication(medication);
      await _notificationService.scheduleMedicationReminders(
        medication: medication,
        petName: petName,
      );
      await loadMedications();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateMedication(
      Medication medication, String petName) async {
    try {
      await _repository.updateMedication(medication);
      await _notificationService.scheduleMedicationReminders(
        medication: medication,
        petName: petName,
      );
      await loadMedications();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteMedication(String id) async {
    try {
      await _notificationService.cancelMedicationReminders(id);
      await _repository.deleteMedication(id);
      await loadMedications();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Mark medication as given: logs timestamp and reschedules next occurrence.
  Future<void> markAsGiven(String medicationId, String petName) async {
    try {
      final now = DateTime.now();
      await _repository.markAsGiven(medicationId, now);
      // Reschedule notifications for the next occurrence
      final medication = await _repository.getMedicationById(medicationId);
      if (medication != null) {
        await _notificationService.scheduleMedicationReminders(
          medication: medication,
          petName: petName,
        );
      }
      await loadMedications();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<int> getMedicationCount() async {
    return _repository.getMedicationCountForPet(petId);
  }
}
