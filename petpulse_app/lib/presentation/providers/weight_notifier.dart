import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/weight_entry.dart';
import '../../domain/repositories/weight_repository.dart';

class WeightNotifier extends StateNotifier<AsyncValue<List<WeightEntry>>> {
  final WeightRepository _repository;
  final String petId;

  WeightNotifier(this._repository, this.petId)
      : super(const AsyncValue.loading()) {
    loadEntries();
  }

  Future<void> loadEntries() async {
    state = const AsyncValue.loading();
    try {
      final entries = await _repository.getWeightEntriesForPet(petId);
      state = AsyncValue.data(entries);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addEntry(WeightEntry entry) async {
    try {
      await _repository.insertWeightEntry(entry);
      await loadEntries();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteEntry(String id) async {
    try {
      await _repository.deleteWeightEntry(id);
      await loadEntries();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
