import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        password TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE water (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount INTEGER
      )
    ''');
  }

  // 🔹 KULLANICI EKLE
  Future<int> insertUser(String username, String password) async {
    final db = await instance.database;

    return await db.insert('users', {
      'username': username,
      'password': password,
    });
  }

  // 🔹 SU EKLE
  Future<int> suEkle(int amount) async {
    final db = await instance.database;

    return await db.insert('water', {
      'amount': amount,
    });
  }

  // 🔹 TOPLAM SU
  Future<int> toplamSu() async {
    final db = await instance.database;

    final result = await db.rawQuery('SELECT SUM(amount) as total FROM water');

    return result.first['total'] == null ? 0 : result.first['total'] as int;
  }
}