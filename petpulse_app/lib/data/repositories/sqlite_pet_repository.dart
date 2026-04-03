import '../../domain/models/pet.dart';
import '../../domain/repositories/pet_repository.dart';
import '../database/app_database.dart';

class SqlitePetRepository implements PetRepository {
  final AppDatabase _db;

  SqlitePetRepository(this._db);

  @override
  Future<List<Pet>> getAllPets() async {
    final db = await _db.database;
    final maps = await db.query('pets', orderBy: 'created_at DESC');
    return maps.map((m) => Pet.fromMap(m)).toList();
  }

  @override
  Future<Pet?> getPetById(String id) async {
    final db = await _db.database;
    final maps = await db.query('pets', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return Pet.fromMap(maps.first);
  }

  @override
  Future<void> insertPet(Pet pet) async {
    final db = await _db.database;
    await db.insert('pets', pet.toMap());
  }

  @override
  Future<void> updatePet(Pet pet) async {
    final db = await _db.database;
    await db.update('pets', pet.toMap(), where: 'id = ?', whereArgs: [pet.id]);
  }

  @override
  Future<void> deletePet(String id) async {
    final db = await _db.database;
    // Delete related records first (cascade)
    await db.delete('vaccinations', where: 'pet_id = ?', whereArgs: [id]);
    await db.delete('medications', where: 'pet_id = ?', whereArgs: [id]);
    await db.delete('weight_entries', where: 'pet_id = ?', whereArgs: [id]);
    await db.delete('pets', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<int> getPetCount() async {
    final db = await _db.database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM pets');
    return result.first['count'] as int;
  }
}
