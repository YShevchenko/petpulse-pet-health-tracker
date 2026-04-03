import '../../domain/models/weight_entry.dart';
import '../../domain/repositories/weight_repository.dart';
import '../database/app_database.dart';

class SqliteWeightRepository implements WeightRepository {
  final AppDatabase _db;

  SqliteWeightRepository(this._db);

  @override
  Future<List<WeightEntry>> getWeightEntriesForPet(String petId) async {
    final db = await _db.database;
    final maps = await db.query(
      'weight_entries',
      where: 'pet_id = ?',
      whereArgs: [petId],
      orderBy: 'date ASC',
    );
    return maps.map((m) => WeightEntry.fromMap(m)).toList();
  }

  @override
  Future<WeightEntry?> getLatestWeightForPet(String petId) async {
    final db = await _db.database;
    final maps = await db.query(
      'weight_entries',
      where: 'pet_id = ?',
      whereArgs: [petId],
      orderBy: 'date DESC',
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return WeightEntry.fromMap(maps.first);
  }

  @override
  Future<void> insertWeightEntry(WeightEntry entry) async {
    final db = await _db.database;
    await db.insert('weight_entries', entry.toMap());
  }

  @override
  Future<void> updateWeightEntry(WeightEntry entry) async {
    final db = await _db.database;
    await db.update(
      'weight_entries',
      entry.toMap(),
      where: 'id = ?',
      whereArgs: [entry.id],
    );
  }

  @override
  Future<void> deleteWeightEntry(String id) async {
    final db = await _db.database;
    await db.delete('weight_entries', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> deleteWeightEntriesForPet(String petId) async {
    final db = await _db.database;
    await db.delete('weight_entries',
        where: 'pet_id = ?', whereArgs: [petId]);
  }
}
