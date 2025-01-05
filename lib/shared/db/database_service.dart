import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    try {
      String path = join(await getDatabasesPath(), 'app_database.db');

      return await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
      );
    } catch (error) {
      return Future.error(error);
    }
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE IF NOT EXISTS todolist (id char(36) PRIMARY KEY UNIQUE, title varchar(255), description TEXT, createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");
    await db.execute("CREATE TABLE IF NOT EXISTS todo (id char(36) PRIMARY KEY UNIQUE, title varchar(255), description TEXT, doData TIMESTAMP, isChecked INTEGER, createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP, todolistId char(36), FOREIGN KEY (todolistId) REFERENCES todolist (id))");
  }

}