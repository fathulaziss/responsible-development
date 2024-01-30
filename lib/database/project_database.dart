import 'package:responsible_development/constants/database_table.dart';
import 'package:responsible_development/entity/project_entity.dart';
import 'package:responsible_development/models/project_model.dart';
import 'package:responsible_development/utils/app_database.dart';
import 'package:sqflite/sqflite.dart';

class ProjectDatabase {
  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE $projectTable(
        ${ProjectEntity.id} TEXT,
        ${ProjectEntity.category} TEXT,
        ${ProjectEntity.name} TEXT,
        ${ProjectEntity.dic} TEXT,
        ${ProjectEntity.pic} TEXT,
        ${ProjectEntity.location} TEXT)
    ''');
  }

  static Future<List<ProjectModel>> selectData() async {
    final db = await AppDatabase().database;

    if (db != null) {
      final dataList = await db.query(projectTable);

      final data =
          List<ProjectModel>.from(dataList.map(ProjectModel.fromDatabase));

      return data;
    } else {
      return [];
    }
  }

  static Future<void> insertData(List<ProjectModel> data) async {
    final db = await AppDatabase().database;
    if (db != null) {
      final batch = db.batch();
      for (final item in data) {
        batch.insert(projectTable, item.toDatabase());
      }
      await batch.commit();
    }
  }

  static Future<void> deleteTable() async {
    final db = await AppDatabase().database;
    if (db != null) {
      await db.delete(projectTable);
    }
  }
}
