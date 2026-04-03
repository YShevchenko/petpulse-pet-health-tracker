import '../models/pet.dart';

abstract class PetRepository {
  Future<List<Pet>> getAllPets();
  Future<Pet?> getPetById(String id);
  Future<void> insertPet(Pet pet);
  Future<void> updatePet(Pet pet);
  Future<void> deletePet(String id);
  Future<int> getPetCount();
}
