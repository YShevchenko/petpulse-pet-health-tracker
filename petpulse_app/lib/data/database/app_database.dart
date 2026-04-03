import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/constants.dart';

class AppDatabase {
  static final AppDatabase _instance = AppDatabase._();
  factory AppDatabase() => _instance;
  AppDatabase._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, AppConstants.databaseName);
    return openDatabase(
      path,
      version: AppConstants.databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(
          'ALTER TABLE pets ADD COLUMN microchip_id TEXT');
      await db.execute(
          'ALTER TABLE medications ADD COLUMN last_given TEXT');
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE pets (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        species TEXT NOT NULL,
        breed TEXT,
        birthday TEXT,
        photo_path TEXT,
        notes TEXT,
        microchip_id TEXT,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE vaccinations (
        id TEXT PRIMARY KEY,
        pet_id TEXT NOT NULL,
        name TEXT NOT NULL,
        date_administered TEXT NOT NULL,
        expiration_date TEXT,
        vet_name TEXT,
        notes TEXT,
        FOREIGN KEY (pet_id) REFERENCES pets(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE medications (
        id TEXT PRIMARY KEY,
        pet_id TEXT NOT NULL,
        name TEXT NOT NULL,
        dosage TEXT,
        frequency TEXT NOT NULL DEFAULT 'daily',
        start_date TEXT NOT NULL,
        end_date TEXT,
        notes TEXT,
        last_given TEXT,
        FOREIGN KEY (pet_id) REFERENCES pets(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE weight_entries (
        id TEXT PRIMARY KEY,
        pet_id TEXT NOT NULL,
        date TEXT NOT NULL,
        weight_kg REAL NOT NULL,
        FOREIGN KEY (pet_id) REFERENCES pets(id) ON DELETE CASCADE
      )
    ''');

    // Indexes for faster lookups
    await db.execute(
        'CREATE INDEX idx_vaccinations_pet ON vaccinations(pet_id)');
    await db.execute(
        'CREATE INDEX idx_medications_pet ON medications(pet_id)');
    await db.execute(
        'CREATE INDEX idx_weight_entries_pet ON weight_entries(pet_id)');
    await db.execute(
        'CREATE INDEX idx_weight_entries_date ON weight_entries(pet_id, date)');
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}
