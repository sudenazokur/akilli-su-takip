import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('su.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE su (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            miktar INTEGER
          )
        ''');
      },
    );
  }

  Future<void> suEkle(int miktar) async {
    final db = await instance.database;
    await db.insert('su', {'miktar': miktar});
  }

  Future<int> toplamSu() async {
    final db = await instance.database;
    final result = await db.rawQuery(
        'SELECT SUM(miktar) as total FROM su');

    return result.first['total'] == null
        ? 0
        : result.first['total'] as int;
  }
}