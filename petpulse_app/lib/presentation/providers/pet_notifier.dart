import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/pet.dart';
import '../../domain/repositories/pet_repository.dart';

class PetNotifier extends StateNotifier<AsyncValue<List<Pet>>> {
  final PetRepository _repository;

  PetNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadPets();
  }

  Future<void> loadPets() async {
    state = const AsyncValue.loading();
    try {
      final pets = await _repository.getAllPets();
      state = AsyncValue.data(pets);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addPet(Pet pet) async {
    try {
      await _repository.insertPet(pet);
      await loadPets();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updatePet(Pet pet) async {
    try {
      await _repository.updatePet(pet);
      await loadPets();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deletePet(String id) async {
    try {
      await _repository.deletePet(id);
      await loadPets();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<int> getPetCount() async {
    return _repository.getPetCount();
  }
}
