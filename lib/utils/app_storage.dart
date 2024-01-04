import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  static Future<void> write({
    required String key,
    required String value,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String> read({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);
    return data ?? '';
  }

  static Future<void> delete({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
