import 'package:responsible_development/common/enum.dart';

class AppConfig {
  static const _urlDevelopment =
      'https://etrace-dev.anj-group.co.id/backend/public/index.php/';
  static const _urlProduction =
      'https://etrace.anj-group.co.id/backend/public/index.php/';

  static late Flavor appFlavor;

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.development:
        return _urlDevelopment;

      case Flavor.production:
        return _urlProduction;
    }
  }

  static String get environmentType {
    switch (appFlavor) {
      case Flavor.development:
        return 'Development';

      case Flavor.production:
        return 'Production';
    }
  }
}
