import '../../domain/models/medication.dart';
import '../../domain/repositories/medication_repository.dart';
import '../database/app_database.dart';

class SqliteMedicationRepository implements MedicationRepository {
  final AppDatabase _db;

  SqliteMedicationRepository(this._db);

  @override
  Future<List<Medication>> getMedicationsForPet(String petId) async {
    final db = await _db.database;
    final maps = await db.query(
      'medications',
      where: 'pet_id = ?',
      whereArgs: [petId],
      orderBy: 'start_date DESC',
    );
    return maps.map((m) => Medication.fromMap(m)).toList();
  }

  @override
  Future<Medication?> getMedicationById(String id) async {
    final db = await _db.database;
    final maps =
        await db.query('medications', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return Medication.fromMap(maps.first);
  }

  @override
  Future<void> insertMedication(Medication medication) async {
    final db = await _db.database;
    await db.insert('medications', medication.toMap());
  }

  @override
  Future<void> updateMedication(Medication medication) async {
    final db = await _db.database;
    await db.update(
      'medications',
      medication.toMap(),
      where: 'id = ?',
      whereArgs: [medication.id],
    );
  }

  @override
  Future<void> deleteMedication(String id) async {
    final db = await _db.database;
    await db.delete('medications', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> deleteMedicationsForPet(String petId) async {
    final db = await _db.database;
    await db.delete('medications', where: 'pet_id = ?', whereArgs: [petId]);
  }

  @override
  Future<List<Medication>> getActiveMedications() async {
    final db = await _db.database;
    final now = DateTime.now().toIso8601String();
    final maps = await db.query(
      'medications',
      where: 'end_date IS NULL OR end_date > ?',
      whereArgs: [now],
      orderBy: 'start_date DESC',
    );
    return maps.map((m) => Medication.fromMap(m)).toList();
  }

  @override
  Future<int> getMedicationCountForPet(String petId) async {
    final db = await _db.database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM medications WHERE pet_id = ?',
      [petId],
    );
    return result.first['count'] as int;
  }

  @override
  Future<void> markAsGiven(String id, DateTime givenAt) async {
    final db = await _db.database;
    await db.update(
      'medications',
      {'last_given': givenAt.toIso8601String()},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
