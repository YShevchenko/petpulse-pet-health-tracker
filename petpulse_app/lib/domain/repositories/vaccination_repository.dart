import '../models/vaccination.dart';

abstract class VaccinationRepository {
  Future<List<Vaccination>> getVaccinationsForPet(String petId);
  Future<Vaccination?> getVaccinationById(String id);
  Future<void> insertVaccination(Vaccination vaccination);
  Future<void> updateVaccination(Vaccination vaccination);
  Future<void> deleteVaccination(String id);
  Future<void> deleteVaccinationsForPet(String petId);
  Future<List<Vaccination>> getExpiringVaccinations({int withinDays = 30});
}
