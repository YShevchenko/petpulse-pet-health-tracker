import 'package:flutter_test/flutter_test.dart';
import 'package:petpulse_app/domain/models/weight_entry.dart';

void main() {
  group('WeightEntry', () {
    test('toMap and fromMap roundtrip', () {
      final entry = WeightEntry(
        id: 'w1',
        petId: 'p1',
        date: DateTime(2025, 6, 1),
        weightKg: 12.5,
      );

      final map = entry.toMap();
      final restored = WeightEntry.fromMap(map);
      expect(restored.id, entry.id);
      expect(restored.petId, entry.petId);
      expect(restored.date, entry.date);
      expect(restored.weightKg, 12.5);
    });

    test('fromMap handles numeric weight correctly', () {
      final map = {
        'id': 'w2',
        'pet_id': 'p1',
        'date': DateTime(2025, 7, 1).toIso8601String(),
        'weight_kg': 8,
      };
      final entry = WeightEntry.fromMap(map);
      expect(entry.weightKg, 8.0);
    });

    test('copyWith works correctly', () {
      final entry = WeightEntry(
        id: 'w3',
        petId: 'p1',
        date: DateTime(2025, 8, 1),
        weightKg: 10.0,
      );
      final modified = entry.copyWith(weightKg: 10.5);
      expect(modified.weightKg, 10.5);
      expect(modified.id, 'w3');
      expect(modified.date, DateTime(2025, 8, 1));
    });

    test('equatable works', () {
      final e1 = WeightEntry(
        id: 'w4',
        petId: 'p1',
        date: DateTime(2025, 9, 1),
        weightKg: 15.0,
      );
      final e2 = WeightEntry(
        id: 'w4',
        petId: 'p1',
        date: DateTime(2025, 9, 1),
        weightKg: 15.0,
      );
      expect(e1, equals(e2));
    });

    test('weight trend calculation', () {
      // Test that we can calculate weight differences
      final entries = [
        WeightEntry(
          id: 'w5',
          petId: 'p1',
          date: DateTime(2025, 1, 1),
          weightKg: 10.0,
        ),
        WeightEntry(
          id: 'w6',
          petId: 'p1',
          date: DateTime(2025, 2, 1),
          weightKg: 10.5,
        ),
        WeightEntry(
          id: 'w7',
          petId: 'p1',
          date: DateTime(2025, 3, 1),
          weightKg: 11.0,
        ),
      ];

      // Calculate gain
      final totalGain = entries.last.weightKg - entries.first.weightKg;
      expect(totalGain, 1.0);

      // Average weight
      final avg =
          entries.map((e) => e.weightKg).reduce((a, b) => a + b) /
              entries.length;
      expect(avg, closeTo(10.5, 0.01));
    });
  });
}
