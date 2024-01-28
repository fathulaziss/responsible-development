import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppDevice {
  static Future<Map<String, dynamic>> information() async {
    final deviceInfo = DeviceInfoPlugin();
    final packageInfo = await PackageInfo.fromPlatform();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;

      final dataInfo = {
        'board': androidInfo.board,
        'brand': androidInfo.brand,
        'device': androidInfo.device,
        'hardware': androidInfo.hardware,
        'host': androidInfo.host,
        'id': androidInfo.id,
        'manufacturer': androidInfo.manufacturer,
        'model': androidInfo.model,
        'os_ver': androidInfo.version.release == ''
            ? 'Andorid'
            : androidInfo.version.release,
        'os': 'android',
        'app_ver': packageInfo.version,
        'version': androidInfo.version.codename,
      };

      return dataInfo;
    } else {
      final iosInfo = await deviceInfo.iosInfo;

      final dataInfo = {
        'id': iosInfo.utsname.machine,
        'brand': 'Apple',
        'model': iosInfo.name,
        'os': 'iOS',
        'os_ver': iosInfo.systemVersion,
        'app_ver': packageInfo.version,
        'version': iosInfo.utsname.release,
      };

      return dataInfo;
    }
  }
}
