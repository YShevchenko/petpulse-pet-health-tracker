import 'package:flutter_test/flutter_test.dart';
import 'package:petpulse_app/domain/models/medication.dart';
import 'package:petpulse_app/domain/models/pet.dart';
import 'package:petpulse_app/domain/models/vaccination.dart';
import 'package:petpulse_app/domain/models/weight_entry.dart';
import 'package:petpulse_app/domain/services/pdf_service.dart';

void main() {
  group('PdfService', () {
    test('generates PDF bytes successfully', () async {
      final pet = Pet(
        id: 'p1',
        name: 'Buddy',
        species: 'dog',
        breed: 'Labrador',
        birthday: DateTime(2020, 5, 10),
        createdAt: DateTime.now(),
      );

      final vaccinations = [
        Vaccination(
          id: 'v1',
          petId: 'p1',
          name: 'Rabies',
          dateAdministered: DateTime(2025, 1, 15),
          expirationDate: DateTime(2026, 1, 15),
          vetName: 'Dr. Smith',
        ),
        Vaccination(
          id: 'v2',
          petId: 'p1',
          name: 'DHPP',
          dateAdministered: DateTime(2025, 3, 1),
        ),
      ];

      final medications = [
        Medication(
          id: 'm1',
          petId: 'p1',
          name: 'Heartguard',
          dosage: '1 tablet',
          frequency: 'monthly',
          startDate: DateTime(2025, 1, 1),
        ),
      ];

      final latestWeight = WeightEntry(
        id: 'w1',
        petId: 'p1',
        date: DateTime(2025, 12, 1),
        weightKg: 28.5,
      );

      final bytes = await PdfService.instance.generatePetPassport(
        pet: pet,
        vaccinations: vaccinations,
        medications: medications,
        latestWeight: latestWeight,
      );

      expect(bytes, isNotEmpty);
      // PDF files start with %PDF
      expect(bytes[0], 0x25); // %
      expect(bytes[1], 0x50); // P
      expect(bytes[2], 0x44); // D
      expect(bytes[3], 0x46); // F
    });

    test('generates PDF with empty vaccinations and medications', () async {
      final pet = Pet(
        id: 'p2',
        name: 'Kitty',
        species: 'cat',
        createdAt: DateTime.now(),
      );

      final bytes = await PdfService.instance.generatePetPassport(
        pet: pet,
        vaccinations: [],
        medications: [],
      );

      expect(bytes, isNotEmpty);
      expect(bytes[0], 0x25); // %
    });
  });
}
