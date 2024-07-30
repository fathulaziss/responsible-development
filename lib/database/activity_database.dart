import 'dart:developer';

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
        ${ActivityEntity.duration} INTEGER,
        ${ActivityEntity.description} TEXT,
        ${ActivityEntity.attachments} TEXT,
        ${ActivityEntity.isSynchronize} INTEGER,
        ${ActivityEntity.projectPeriode} TEXT,
        ${ActivityEntity.monthPeriode} TEXT,
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

      final data =
          List<ActivityModel>.from(mapList.map(ActivityModel.fromDatabase));
      return data;
    }

    return [];
  }

  static Future<double> selectDataSummary({
    required String projectName,
    required String periode,
    String? monthPeriode,
  }) async {
    final db = await AppDatabase().database;

    if (db != null) {
      final user = await UserDatabase.selectData();
      if (monthPeriode == null) {
        final mapList = await db.query(
          activityTable,
          where:
              '${ActivityEntity.userId}=? AND ${ActivityEntity.projectName}=? AND ${ActivityEntity.projectPeriode}=?',
          whereArgs: [user.id, projectName, periode],
        );

        final data =
            List<ActivityModel>.from(mapList.map(ActivityModel.fromDatabase));
        if (data.isNotEmpty) {
          final totalDurationInPeriode = data.fold(
            0,
            (previousValue, element) => previousValue + element.duration,
          );
          return totalDurationInPeriode / 60;
        } else {
          return 0.0;
        }
      } else {
        final mapList = await db.query(
          activityTable,
          where:
              '${ActivityEntity.userId}=? AND ${ActivityEntity.projectName}=? AND ${ActivityEntity.projectPeriode}=? AND ${ActivityEntity.monthPeriode}=?',
          whereArgs: [user.id, projectName, periode, monthPeriode],
        );

        final data =
            List<ActivityModel>.from(mapList.map(ActivityModel.fromDatabase));
        log('check query $monthPeriode : $data');
        if (data.isNotEmpty) {
          final totalDurationInMonthPeriode = data.fold(
            0,
            (previousValue, element) => previousValue + element.duration,
          );
          return totalDurationInMonthPeriode / 60;
        } else {
          return 0.0;
        }
      }
    }

    return 0.0;
  }

  static Future<void> insertData(ActivityModel data) async {
    final db = await AppDatabase().database;
    if (db != null) {
      await db.insert(activityTable, data.toDatabase());
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

      final data =
          List<ActivityModel>.from(mapList.map(ActivityModel.fromDatabase));
      return data;
    }

    return [];
  }

  static Future<void> updateData(ActivityModel data) async {
    final db = await AppDatabase().database;
    if (db != null) {
      await db.update(
        activityTable,
        data.toDatabase(),
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
