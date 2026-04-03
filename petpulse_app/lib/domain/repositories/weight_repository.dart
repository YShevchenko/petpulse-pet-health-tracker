import '../models/weight_entry.dart';

abstract class WeightRepository {
  Future<List<WeightEntry>> getWeightEntriesForPet(String petId);
  Future<WeightEntry?> getLatestWeightForPet(String petId);
  Future<void> insertWeightEntry(WeightEntry entry);
  Future<void> updateWeightEntry(WeightEntry entry);
  Future<void> deleteWeightEntry(String id);
  Future<void> deleteWeightEntriesForPet(String petId);
}
