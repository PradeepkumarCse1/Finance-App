import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {

  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "app_database.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  static Future<void> _onCreate(
      Database db, int version) async {

    /// 🔥 Categories Table
    await db.execute('''
      CREATE TABLE categories(
        id TEXT PRIMARY KEY,
        name TEXT,
        is_synced INTEGER,
        is_deleted INTEGER
      )
    ''');

    // /// 🔥 Transactions Table (if needed)
    // await db.execute('''
    //   CREATE TABLE transactions(
    //     id TEXT PRIMARY KEY,
    //     title TEXT,
    //     amount REAL,
    //     category_id TEXT,
    //     is_synced INTEGER,
    //     is_deleted INTEGER
    //   )
    // ''');
  }
}