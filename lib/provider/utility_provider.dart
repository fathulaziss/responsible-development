import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:responsible_development/common/common_parameter.dart';
import 'package:responsible_development/common/styles.dart';
import 'package:responsible_development/models/app_langauage_model.dart';
import 'package:responsible_development/utils/app_storage.dart';

class UtilityProvider extends ChangeNotifier {
  UtilityProvider() {
    _getAppVersion();
    _getTheme();
    _getAppLanguage();
  }

  String _appVersion = '';

  bool _isDarkTheme = false;

  AppLanguageModel _appLanguage =
      const AppLanguageModel(countryCode: 'US', languageCode: 'en');

  String get appVersion => _appVersion;

  bool get isDarkTheme => _isDarkTheme;

  AppLanguageModel get appLanguage => _appLanguage;

  ThemeData get theme => _isDarkTheme ? darkTheme : lightTheme;

  Future<void> _getAppVersion() async {
    final cm = await CommonParameter.params();
    _appVersion = 'v.${cm.appVersion}';
    notifyListeners();
  }

  Future<void> _getTheme() async {
    final data = await AppStorage.read(key: 'dark_theme');
    if (data.isNotEmpty) {
      _isDarkTheme = jsonDecode(data);
      notifyListeners();
    }
  }

  Future<void> _getAppLanguage() async {
    final data = await AppStorage.read(key: 'app_language');
    if (data.isNotEmpty) {
      _appLanguage = AppLanguageModel.fromJson(jsonDecode(data));
      notifyListeners();
    }
  }

  Future<void> setDarkTheme({required bool value}) async {
    await AppStorage.write(key: 'dark_theme', value: jsonEncode(value));
    await _getTheme();
  }

  Future<void> setAppLanguage(AppLanguageModel value) async {
    await AppStorage.write(
      key: 'app_language',
      value: jsonEncode(value.toJson()),
    );
    await _getAppLanguage();
  }
}
