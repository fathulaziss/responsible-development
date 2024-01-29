import 'package:flutter/material.dart';
import 'package:responsible_development/api/api_endpoint.dart';
import 'package:responsible_development/common/enum.dart';
import 'package:responsible_development/database/user_database.dart';
import 'package:responsible_development/models/login_data_model.dart';
import 'package:responsible_development/models/user_model.dart';
import 'package:responsible_development/services/api_service.dart';
import 'package:responsible_development/utils/app_database.dart';
import 'package:responsible_development/utils/app_storage.dart';

class AuthRepository {
  static Future<void> login({
    required String username,
    required String password,
    required ValueSetter<LoginDataModel> onSuccess,
    required ValueSetter<String> onError,
  }) async {
    try {
      final body = {'username': username, 'password': password};

      final response = await ApiService().request(
        endPoint: ApiEndpoint.signin,
        method: Method.post,
        useToken: false,
        body: body,
      );

      if (response.success) {
        final data = LoginDataModel.fromMap(response.data);

        await AppStorage.write(key: 'token', value: '${data.token}');
        await AppStorage.write(
          key: 'token_expired_at',
          value: '${data.tokenExpiredAt}',
        );
        await AppStorage.write(key: 'username', value: username);

        await UserDatabase.insertData(data.user ?? UserModel());

        onSuccess(data);
      } else {
        onError(response.message);
      }
    } catch (e) {
      onError(e.toString());
    }
  }

  static Future<void> logout({
    required ValueSetter<String> onSuccess,
    required ValueSetter<String> onError,
  }) async {
    try {
      final response = await ApiService().request(
        endPoint: ApiEndpoint.signout,
        method: Method.get,
      );

      if (response.success) {
        await AppStorage.delete(key: 'token');
        await AppStorage.delete(key: 'token_expired_at');
        await AppDatabase().deleteDatabase();

        onSuccess(response.message);
      } else {
        onError(response.message);
      }
    } catch (e) {
      onError(e.toString());
    }
  }
}
