import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('akilli_su_takip.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
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
      CREATE TABLE water_usage (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category TEXT,
        amount INTEGER,
        date TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE card_transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        card_id TEXT,
        amount REAL,
        type TEXT,
        date TEXT
      )
    ''');

    // İlk açılışta tasarımdaki görsel verilerin aynısını ekliyoruz
    await db.insert('water_usage', {'category': 'Mutfak', 'amount': 120, 'date': '2026-05-19'});
    await db.insert('water_usage', {'category': 'Banyo', 'amount': 80, 'date': '2026-05-19'});
    await db.insert('water_usage', {'category': 'Tuvalet', 'amount': 45, 'date': '2026-05-19'});
    await db.insert('water_usage', {'category': 'Çamaşır Makinesi', 'amount': 20, 'date': '2026-05-19'});
    
    await db.insert('card_transactions', {'card_id': '1234 5678', 'amount': 100.0, 'type': 'Yükleme', 'date': '5 Mart 2025'});
    await db.insert('card_transactions', {'card_id': '9876 5432', 'amount': 50.0, 'type': 'Yükleme', 'date': '25 Şub 2025'});
  }

  Future<int> insertUser(String username, String password) async {
    final db = await instance.database;
    return await db.insert('users', {'username': username, 'password': password});
  }

  Future<int> toplamSuTuketimi() async {
    final db = await instance.database;
    final result = await db.rawQuery('SELECT SUM(amount) as total FROM water_usage');
    return result.first['total'] == null ? 0 : result.first['total'] as int;
  }

  Future<int> kategoriTuketimi(String category) async {
    final db = await instance.database;
    final result = await db.rawQuery('SELECT SUM(amount) as total FROM water_usage WHERE category = ?', [category]);
    return result.first['total'] == null ? 0 : result.first['total'] as int;
  }

  Future<double> kartBakiyesiGetir() async {
    final db = await instance.database;
    final result = await db.rawQuery("SELECT SUM(amount) as total FROM card_transactions");
    return result.first['total'] == null ? 0.0 : double.parse(result.first['total'].toString());
  }

  Future<int> bakiyeYukle(String cardId, double amount) async {
    final db = await instance.database;
    return await db.insert('card_transactions', {
      'card_id': cardId,
      'amount': amount,
      'type': 'Yükleme',
      'date': '${DateTime.now().day} Mayıs 2026'
    });
  }

  Future<List<Map<String, dynamic>>> sonIslemleriGetir() async {
    final db = await instance.database;
    return await db.query('card_transactions', orderBy: 'id DESC', limit: 5);
  }
}