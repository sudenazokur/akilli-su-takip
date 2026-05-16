import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('su_takip.db');
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

  // 📌 TABLOLAR
  Future _createDB(Database db, int version) async {

    // 👤 Kullanıcı tablosu
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        surname TEXT,
        email TEXT
      )
    ''');

    // 💧 Su kullanımı
    await db.execute('''
      CREATE TABLE usage (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        litre INTEGER,
        tarih TEXT
      )
    ''');

    // 💳 Kart bilgisi
    await db.execute('''
      CREATE TABLE cards (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cardId TEXT
      )
    ''');
  }

  // 📌 KULLANICI EKLEME
  Future<int> insertUser(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('users', row);
  }

  // 📌 SU KULLANIM EKLEME
  Future<int> insertUsage(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('usage', row);
  }

  // 📌 KART EKLEME
  Future<int> insertCard(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('cards', row);
  }

  // 📌 VERİLERİ ÇEKME
  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await instance.database;
    return await db.query('users');
  }

  Future<List<Map<String, dynamic>>> getUsage() async {
    final db = await instance.database;
    return await db.query('usage');
  }

  Future<List<Map<String, dynamic>>> getCards() async {
    final db = await instance.database;
    return await db.query('cards');
  }
}