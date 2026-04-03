import 'package:flutter_test/flutter_test.dart';
import 'package:petpulse_app/domain/models/vaccination.dart';

void main() {
  group('Vaccination', () {
    test('toMap and fromMap roundtrip', () {
      final vax = Vaccination(
        id: 'v1',
        petId: 'p1',
        name: 'Rabies',
        dateAdministered: DateTime(2025, 1, 15),
        expirationDate: DateTime(2026, 1, 15),
        vetName: 'Dr. Smith',
        notes: 'Yearly booster',
      );

      final map = vax.toMap();
      final restored = Vaccination.fromMap(map);
      expect(restored.id, vax.id);
      expect(restored.name, 'Rabies');
      expect(restored.vetName, 'Dr. Smith');
      expect(restored.expirationDate, DateTime(2026, 1, 15));
    });

    test('daysUntilExpiry is null when no expiration date', () {
      final vax = Vaccination(
        id: 'v2',
        petId: 'p1',
        name: 'Distemper',
        dateAdministered: DateTime(2025, 6, 1),
      );
      expect(vax.daysUntilExpiry, isNull);
    });

    test('daysUntilExpiry returns positive for future date', () {
      final futureDate = DateTime.now().add(const Duration(days: 60));
      final vax = Vaccination(
        id: 'v3',
        petId: 'p1',
        name: 'Parvo',
        dateAdministered: DateTime.now(),
        expirationDate: futureDate,
      );
      expect(vax.daysUntilExpiry! > 0, isTrue);
    });

    test('daysUntilExpiry returns negative for past date', () {
      final pastDate = DateTime.now().subtract(const Duration(days: 10));
      final vax = Vaccination(
        id: 'v4',
        petId: 'p1',
        name: 'Bordetella',
        dateAdministered: DateTime(2025, 1, 1),
        expirationDate: pastDate,
      );
      expect(vax.daysUntilExpiry! < 0, isTrue);
      expect(vax.isExpired, isTrue);
    });

    test('expiryStatus returns green for > 30 days', () {
      final vax = Vaccination(
        id: 'v5',
        petId: 'p1',
        name: 'Test',
        dateAdministered: DateTime.now(),
        expirationDate: DateTime.now().add(const Duration(days: 60)),
      );
      expect(vax.expiryStatus, 'green');
    });

    test('expiryStatus returns yellow for 8-30 days', () {
      final vax = Vaccination(
        id: 'v6',
        petId: 'p1',
        name: 'Test',
        dateAdministered: DateTime.now(),
        expirationDate: DateTime.now().add(const Duration(days: 15)),
      );
      expect(vax.expiryStatus, 'yellow');
    });

    test('expiryStatus returns yellow for 1-30 days (not yet expired)', () {
      final vax = Vaccination(
        id: 'v7',
        petId: 'p1',
        name: 'Test',
        dateAdministered: DateTime.now(),
        expirationDate: DateTime.now().add(const Duration(days: 5)),
      );
      expect(vax.expiryStatus, 'yellow');
    });

    test('expiryStatus returns red for expired', () {
      final vax = Vaccination(
        id: 'v8',
        petId: 'p1',
        name: 'Test',
        dateAdministered: DateTime.now().subtract(const Duration(days: 400)),
        expirationDate: DateTime.now().subtract(const Duration(days: 30)),
      );
      expect(vax.expiryStatus, 'red');
      expect(vax.isExpired, isTrue);
    });

    test('expiryStatus returns green when no expiration', () {
      final vax = Vaccination(
        id: 'v9',
        petId: 'p1',
        name: 'Test',
        dateAdministered: DateTime.now(),
      );
      expect(vax.expiryStatus, 'green');
      expect(vax.isExpired, isFalse);
    });
  });
}
