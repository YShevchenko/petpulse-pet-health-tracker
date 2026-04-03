import 'package:flutter_test/flutter_test.dart';
import 'package:petpulse_app/domain/models/pet.dart';

void main() {
  group('Pet', () {
    final now = DateTime(2026, 4, 2, 12, 0, 0);
    final birthday = DateTime(2020, 6, 15);

    final pet = Pet(
      id: '1',
      name: 'Buddy',
      species: 'dog',
      breed: 'Golden Retriever',
      birthday: birthday,
      photoPath: '/photos/buddy.jpg',
      notes: 'Good boy',
      createdAt: now,
    );

    test('toMap converts Pet to map correctly', () {
      final map = pet.toMap();
      expect(map['id'], '1');
      expect(map['name'], 'Buddy');
      expect(map['species'], 'dog');
      expect(map['breed'], 'Golden Retriever');
      expect(map['birthday'], birthday.toIso8601String());
      expect(map['photo_path'], '/photos/buddy.jpg');
      expect(map['notes'], 'Good boy');
      expect(map['created_at'], now.toIso8601String());
    });

    test('fromMap creates Pet from map correctly', () {
      final map = pet.toMap();
      final restored = Pet.fromMap(map);
      expect(restored.id, pet.id);
      expect(restored.name, pet.name);
      expect(restored.species, pet.species);
      expect(restored.breed, pet.breed);
      expect(restored.birthday, pet.birthday);
      expect(restored.photoPath, pet.photoPath);
      expect(restored.notes, pet.notes);
    });

    test('fromMap handles null optional fields', () {
      final map = {
        'id': '2',
        'name': 'Kitty',
        'species': 'cat',
        'created_at': now.toIso8601String(),
      };
      final restored = Pet.fromMap(map);
      expect(restored.birthday, isNull);
      expect(restored.photoPath, isNull);
      expect(restored.notes, isNull);
      expect(restored.breed, '');
    });

    test('copyWith creates a new Pet with modified fields', () {
      final modified = pet.copyWith(name: 'Max');
      expect(modified.name, 'Max');
      expect(modified.species, 'dog');
      expect(modified.id, '1');
    });

    test('ageString returns correct age', () {
      // Pet born 2020-06-15, "now" is 2026-04-02
      // That's about 5 years, 9 months
      expect(pet.ageString, isNotEmpty);
      expect(pet.ageString.contains('yr'), isTrue);
    });

    test('ageString returns empty for null birthday', () {
      // copyWith doesn't clear birthday since it defaults to existing value.
      // We need a special case: create new pet without birthday.
      final p = Pet(
        id: '3',
        name: 'Test',
        species: 'cat',
        createdAt: now,
      );
      expect(p.ageString, '');
    });

    test('equatable works correctly', () {
      final same = Pet(
        id: '1',
        name: 'Buddy',
        species: 'dog',
        breed: 'Golden Retriever',
        birthday: birthday,
        photoPath: '/photos/buddy.jpg',
        notes: 'Good boy',
        createdAt: now,
      );
      expect(pet, equals(same));
    });

    test('equatable detects differences', () {
      final different = pet.copyWith(name: 'NotBuddy');
      expect(pet, isNot(equals(different)));
    });
  });
}
