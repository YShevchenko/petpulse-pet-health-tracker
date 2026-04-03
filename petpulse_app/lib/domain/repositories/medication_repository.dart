import '../models/medication.dart';

abstract class MedicationRepository {
  Future<List<Medication>> getMedicationsForPet(String petId);
  Future<Medication?> getMedicationById(String id);
  Future<void> insertMedication(Medication medication);
  Future<void> updateMedication(Medication medication);
  Future<void> deleteMedication(String id);
  Future<void> deleteMedicationsForPet(String petId);
  Future<List<Medication>> getActiveMedications();
  Future<int> getMedicationCountForPet(String petId);
  Future<void> markAsGiven(String id, DateTime givenAt);
}
