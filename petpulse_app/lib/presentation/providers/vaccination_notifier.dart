import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/vaccination.dart';
import '../../domain/repositories/vaccination_repository.dart';
import '../../domain/services/notification_service.dart';

class VaccinationNotifier
    extends StateNotifier<AsyncValue<List<Vaccination>>> {
  final VaccinationRepository _repository;
  final NotificationService _notificationService;
  final String petId;

  VaccinationNotifier(this._repository, this._notificationService, this.petId)
      : super(const AsyncValue.loading()) {
    loadVaccinations();
  }

  Future<void> loadVaccinations() async {
    state = const AsyncValue.loading();
    try {
      final vaccinations = await _repository.getVaccinationsForPet(petId);
      state = AsyncValue.data(vaccinations);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addVaccination(
      Vaccination vaccination, String petName) async {
    try {
      await _repository.insertVaccination(vaccination);
      await _notificationService.scheduleVaccinationAlerts(
        vaccination: vaccination,
        petName: petName,
      );
      await loadVaccinations();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateVaccination(
      Vaccination vaccination, String petName) async {
    try {
      await _repository.updateVaccination(vaccination);
      await _notificationService.scheduleVaccinationAlerts(
        vaccination: vaccination,
        petName: petName,
      );
      await loadVaccinations();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteVaccination(String id) async {
    try {
      await _notificationService.cancelVaccinationAlerts(id);
      await _repository.deleteVaccination(id);
      await loadVaccinations();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
