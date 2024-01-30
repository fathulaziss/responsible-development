import 'package:responsible_development/constants/database_table.dart';
import 'package:responsible_development/entity/user_entity.dart';
import 'package:responsible_development/models/user_model.dart';
import 'package:responsible_development/utils/app_database.dart';
import 'package:sqflite/sqflite.dart';

class UserDatabase {
  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE $userTable(
       ${UserEntity.id} TEXT,
       ${UserEntity.code} TEXT,
       ${UserEntity.name} TEXT,
       ${UserEntity.email} TEXT,
       ${UserEntity.emailVerifiedAt} TEXT,
       ${UserEntity.mRoleId} TEXT,
       ${UserEntity.username} TEXT,
       ${UserEntity.address} TEXT,
       ${UserEntity.gender} TEXT,
       ${UserEntity.rememberToken} TEXT,
       ${UserEntity.mCompanyId} TEXT,
       ${UserEntity.mEmployeeHrisId} TEXT,
       ${UserEntity.phoneNumber} TEXT,
       ${UserEntity.lastLogin} TEXT,
       ${UserEntity.loginStatus} TEXT,
       ${UserEntity.lastConnected} TEXT,
       ${UserEntity.mOccupationId} TEXT,
       ${UserEntity.mDepartmentId} TEXT,
       ${UserEntity.mMillId} TEXT,
       ${UserEntity.groupName} TEXT,
       ${UserEntity.level} INTEGER,
       ${UserEntity.employeeCode} TEXT,
       ${UserEntity.employeeNumber} TEXT,
       ${UserEntity.supervisorEmployeeCode} TEXT,
       ${UserEntity.isActive} INTEGER,
       ${UserEntity.createdAt} TEXT,
       ${UserEntity.createdBy} TEXT,
       ${UserEntity.updatedAt} TEXT,
       ${UserEntity.updatedBy} TEXT)
    ''');
  }

  static Future<UserModel> selectData() async {
    final db = await AppDatabase().database;
    var data = UserModel();
    if (db != null) {
      final temp = await db.query(userTable);
      data = UserModel.fromMap(temp.first);
    }

    return data;
  }

  static Future<void> insertData(UserModel data) async {
    final db = await AppDatabase().database;
    if (db != null) {
      await db.insert(userTable, data.toMap());
    }
  }

  static Future<void> deleteTable() async {
    final db = await AppDatabase().database;
    if (db != null) {
      await db.delete(userTable);
    }
  }
}
