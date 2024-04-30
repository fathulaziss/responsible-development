import 'package:responsible_development/database/activity_database.dart';
import 'package:responsible_development/database/my_project_database.dart';
import 'package:responsible_development/database/project_database.dart';
import 'package:responsible_development/database/user_database.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  factory AppDatabase() => _instance ?? AppDatabase._internal();

  AppDatabase._internal() {
    _instance = this;
  }

  static AppDatabase? _instance;
  static Database? _database;

  Future<Database?> get database async {
    return _database ??= await initDatabase();
  }

  Future<Database> initDatabase() async {
    final path = await getDatabasesPath();

    final db = openDatabase(
      '$path/db_responsible_development.db',
      onCreate: createDatabase,
      version: 1,
    );

    return db;
  }

  Future<void> createDatabase(Database db, int version) async {
    await UserDatabase.createTable(db);
    await ProjectDatabase.createTable(db);
    await MyProjectDatabase.createTable(db);
    await ActivityDatabase.createTable(db);
  }

  Future<void> deleteDatabase() async {
    await UserDatabase.deleteTable();
    await ProjectDatabase.deleteTable();
    await MyProjectDatabase.deleteTable();
    await ActivityDatabase.deleteTable();
  }
}
