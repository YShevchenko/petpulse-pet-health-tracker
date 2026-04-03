import '../../domain/models/vaccination.dart';
import '../../domain/repositories/vaccination_repository.dart';
import '../database/app_database.dart';

class SqliteVaccinationRepository implements VaccinationRepository {
  final AppDatabase _db;

  SqliteVaccinationRepository(this._db);

  @override
  Future<List<Vaccination>> getVaccinationsForPet(String petId) async {
    final db = await _db.database;
    final maps = await db.query(
      'vaccinations',
      where: 'pet_id = ?',
      whereArgs: [petId],
      orderBy: 'date_administered DESC',
    );
    return maps.map((m) => Vaccination.fromMap(m)).toList();
  }

  @override
  Future<Vaccination?> getVaccinationById(String id) async {
    final db = await _db.database;
    final maps =
        await db.query('vaccinations', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return Vaccination.fromMap(maps.first);
  }

  @override
  Future<void> insertVaccination(Vaccination vaccination) async {
    final db = await _db.database;
    await db.insert('vaccinations', vaccination.toMap());
  }

  @override
  Future<void> updateVaccination(Vaccination vaccination) async {
    final db = await _db.database;
    await db.update(
      'vaccinations',
      vaccination.toMap(),
      where: 'id = ?',
      whereArgs: [vaccination.id],
    );
  }

  @override
  Future<void> deleteVaccination(String id) async {
    final db = await _db.database;
    await db.delete('vaccinations', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> deleteVaccinationsForPet(String petId) async {
    final db = await _db.database;
    await db.delete('vaccinations', where: 'pet_id = ?', whereArgs: [petId]);
  }

  @override
  Future<List<Vaccination>> getExpiringVaccinations(
      {int withinDays = 30}) async {
    final db = await _db.database;
    final now = DateTime.now();
    final threshold = now.add(Duration(days: withinDays));
    final maps = await db.query(
      'vaccinations',
      where: 'expiration_date IS NOT NULL AND expiration_date <= ?',
      whereArgs: [threshold.toIso8601String()],
      orderBy: 'expiration_date ASC',
    );
    return maps.map((m) => Vaccination.fromMap(m)).toList();
  }
}
