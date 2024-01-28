import 'package:responsible_development/models/common_parameter_model.dart';
import 'package:responsible_development/utils/app_device.dart';
import 'package:responsible_development/utils/app_storage.dart';

class CommonParameter {
  static Future<CommonParameterModel> params() async {
    final token = await AppStorage.read(key: 'token');
    final deviceInfo = await AppDevice.information();

    final data = CommonParameterModel(
      token: token,
      appVersion: deviceInfo['app_ver'],
      appPlatform: deviceInfo['os'],
    );

    return data;
  }
}
