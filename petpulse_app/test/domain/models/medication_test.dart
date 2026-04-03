import 'package:flutter_test/flutter_test.dart';
import 'package:petpulse_app/domain/models/medication.dart';

void main() {
  group('Medication', () {
    test('toMap and fromMap roundtrip', () {
      final med = Medication(
        id: 'm1',
        petId: 'p1',
        name: 'Heartguard',
        dosage: '1 tablet',
        frequency: 'monthly',
        startDate: DateTime(2025, 3, 1),
        endDate: DateTime(2026, 3, 1),
        notes: 'Give with food',
      );

      final map = med.toMap();
      final restored = Medication.fromMap(map);
      expect(restored.id, med.id);
      expect(restored.name, 'Heartguard');
      expect(restored.dosage, '1 tablet');
      expect(restored.frequency, 'monthly');
      expect(restored.endDate, DateTime(2026, 3, 1));
    });

    test('isActive returns true when no end date', () {
      final med = Medication(
        id: 'm2',
        petId: 'p1',
        name: 'Vitamin',
        dosage: '1ml',
        frequency: 'daily',
        startDate: DateTime.now(),
      );
      expect(med.isActive, isTrue);
    });

    test('isActive returns true when end date in future', () {
      final med = Medication(
        id: 'm3',
        petId: 'p1',
        name: 'Antibiotic',
        dosage: '2 pills',
        frequency: 'daily',
        startDate: DateTime.now().subtract(const Duration(days: 5)),
        endDate: DateTime.now().add(const Duration(days: 5)),
      );
      expect(med.isActive, isTrue);
    });

    test('isActive returns false when end date in past', () {
      final med = Medication(
        id: 'm4',
        petId: 'p1',
        name: 'Old Med',
        dosage: '1 pill',
        frequency: 'daily',
        startDate: DateTime.now().subtract(const Duration(days: 30)),
        endDate: DateTime.now().subtract(const Duration(days: 1)),
      );
      expect(med.isActive, isFalse);
    });

    test('nextDue for daily medication returns today or tomorrow', () {
      final med = Medication(
        id: 'm5',
        petId: 'p1',
        name: 'Daily Med',
        frequency: 'daily',
        startDate: DateTime.now(),
      );
      final due = med.nextDue;
      final today = DateTime.now();
      // nextDue should be today at 9AM or tomorrow at 9AM
      expect(due.hour, 9);
      expect(
        due.day == today.day || due.day == today.day + 1 ||
            (today.day > due.day), // month rollover
        isTrue,
      );
    });

    test('nextDue for weekly medication returns correct weekday', () {
      final startDate = DateTime(2025, 3, 3); // Monday
      final med = Medication(
        id: 'm6',
        petId: 'p1',
        name: 'Weekly Med',
        frequency: 'weekly',
        startDate: startDate,
      );
      final due = med.nextDue;
      expect(due.weekday, DateTime.monday);
    });

    test('nextDue for monthly medication returns correct day', () {
      final startDate = DateTime(2025, 1, 15);
      final med = Medication(
        id: 'm7',
        petId: 'p1',
        name: 'Monthly Med',
        frequency: 'monthly',
        startDate: startDate,
      );
      final due = med.nextDue;
      expect(due.day, 15);
    });

    test('copyWith works correctly', () {
      final med = Medication(
        id: 'm8',
        petId: 'p1',
        name: 'Test',
        frequency: 'daily',
        startDate: DateTime.now(),
      );
      final modified = med.copyWith(name: 'Modified', dosage: '5ml');
      expect(modified.name, 'Modified');
      expect(modified.dosage, '5ml');
      expect(modified.id, 'm8');
    });

    test('fromMap handles null optional fields', () {
      final map = {
        'id': 'm9',
        'pet_id': 'p1',
        'name': 'Basic',
        'start_date': DateTime.now().toIso8601String(),
      };
      final med = Medication.fromMap(map);
      expect(med.endDate, isNull);
      expect(med.notes, isNull);
      expect(med.dosage, '');
      expect(med.frequency, 'daily');
    });
  });
}
