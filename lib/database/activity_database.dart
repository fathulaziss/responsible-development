import 'package:responsible_development/constants/database_table.dart';
import 'package:responsible_development/database/user_database.dart';
import 'package:responsible_development/entity/activity_entity.dart';
import 'package:responsible_development/models/activity_model.dart';
import 'package:responsible_development/utils/app_database.dart';
import 'package:sqflite/sqflite.dart';

class ActivityDatabase {
  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE $activityTable(
        ${ActivityEntity.id} TEXT,
        ${ActivityEntity.userId} TEXT,
        ${ActivityEntity.date} TEXT,
        ${ActivityEntity.projectId} TEXT,
        ${ActivityEntity.projectName} TEXT,
        ${ActivityEntity.startTime} TEXT,
        ${ActivityEntity.finishTime} TEXT,
        ${ActivityEntity.description} TEXT,
        ${ActivityEntity.isSynchronize} INTEGER,
        ${ActivityEntity.createdAt} TEXT,
        ${ActivityEntity.updatedAt} TEXT)
    ''');
  }

  static Future<List<ActivityModel>> selectData() async {
    final db = await AppDatabase().database;

    if (db != null) {
      final user = await UserDatabase.selectData();
      final mapList = await db.query(
        activityTable,
        where: '${ActivityEntity.userId}=?',
        whereArgs: [user.id],
      );

      final data = List<ActivityModel>.from(mapList.map(ActivityModel.fromMap));
      return data;
    }

    return [];
  }

  static Future<void> insertData(ActivityModel data) async {
    final db = await AppDatabase().database;
    if (db != null) {
      await db.insert(activityTable, data.toMap());
    }
  }

  static Future<List<ActivityModel>> selectDataUnUpload() async {
    final db = await AppDatabase().database;

    if (db != null) {
      final user = await UserDatabase.selectData();
      final mapList = await db.query(
        activityTable,
        where:
            '${ActivityEntity.userId}=? AND ${ActivityEntity.isSynchronize}=?',
        whereArgs: [user.id, 0],
      );

      final data = List<ActivityModel>.from(mapList.map(ActivityModel.fromMap));
      return data;
    }

    return [];
  }

  static Future<void> updateData(ActivityModel data) async {
    final db = await AppDatabase().database;
    if (db != null) {
      await db.update(
        activityTable,
        data.toMap(),
        where: '${ActivityEntity.id}=?',
        whereArgs: [data.id],
      );
    }
  }

  static Future<void> deleteTable() async {
    final db = await AppDatabase().database;
    if (db != null) {
      await db.delete(activityTable);
    }
  }
}
