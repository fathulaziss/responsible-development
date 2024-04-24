import 'package:responsible_development/models/access_model.dart';
import 'package:responsible_development/models/user_model.dart';

class LoginDataModel {
  LoginDataModel({this.token, this.tokenExpiredAt, this.user, this.access});

  factory LoginDataModel.fromMap(Map<String, dynamic> map) {
    return LoginDataModel(
      token: map['token'],
      tokenExpiredAt: map['token_expired_at'],
      user: map['user'] != null ? UserModel.fromMap(map['user']) : UserModel(),
      access: map['access'] != null
          ? List<AccessModel>.from(
              (map['access'] as List).map((e) => AccessModel.fromMap),
            )
          : <AccessModel>[],
    );
  }

  String? token;
  String? tokenExpiredAt;
  UserModel? user;
  List<AccessModel>? access;

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'token_expired_at': tokenExpiredAt,
      'user': user?.toMap(),
      'access': List.from(access!.map((e) => e.toMap())),
    };
  }

  @override
  String toString() {
    return 'LoginDataModel(success: $token, token_expired_at: $tokenExpiredAt, user: $user, access: $access)';
  }
}
