import 'package:responsible_development/constants/database_table.dart';
import 'package:responsible_development/entity/my_project_entity.dart';
import 'package:responsible_development/models/my_project_model.dart';
import 'package:responsible_development/utils/app_database.dart';
import 'package:sqflite/sqflite.dart';

class MyProjectDatabase {
  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE $myProjectTable(
        ${MyProjectEntity.percentage} REAL,
        ${MyProjectEntity.id} TEXT,
        ${MyProjectEntity.category} TEXT,
        ${MyProjectEntity.name} TEXT,
        ${MyProjectEntity.dic} TEXT,
        ${MyProjectEntity.pic} TEXT,
        ${MyProjectEntity.location} TEXT)
    ''');
  }

  static Future<void> insertData(List<MyProjectModel> data) async {
    final db = await AppDatabase().database;
    if (db != null) {
      final batch = db.batch();
      for (final item in data) {
        batch.insert(myProjectTable, item.toDatabase());
      }
      await batch.commit();
    }
  }

  static Future<void> deleteTable() async {
    final db = await AppDatabase().database;
    if (db != null) {
      await db.delete(myProjectTable);
    }
  }
}
