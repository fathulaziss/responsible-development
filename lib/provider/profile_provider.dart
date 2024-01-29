import 'package:flutter/material.dart';
import 'package:responsible_development/database/user_database.dart';
import 'package:responsible_development/models/user_model.dart';

class ProfileProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel get user => _user ?? UserModel();

  Future<void> getUser() async {
    final data = await UserDatabase.selectData();
    _user = data;
    notifyListeners();
  }
}
