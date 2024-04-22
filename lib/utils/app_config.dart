import 'package:responsible_development/common/enum.dart';

class AppConfig {
  static const _urlDevelopment =
      'https://inspection.anj-group.co.id/public/index.php/api/v1/';
  static const _urlProduction =
      'https://inspection.anj-group.co.id/public/index.php/api/v1/';

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
