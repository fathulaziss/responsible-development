import 'package:responsible_development/services/navigation_service.dart';
import 'package:responsible_development/ui/login/login_view.dart';
import 'package:responsible_development/utils/app_utils.dart';

class AppCycleService {
  factory AppCycleService() {
    return _instance;
  }

  AppCycleService._internal() {
    AppUtils.logger('AppCylceService Initialized');
  }

  static final AppCycleService _instance = AppCycleService._internal();

  Future<void> checkTokenAndRoute() async {
    try {
      //* CHECK LOGGING USER
      await Future.delayed(const Duration(seconds: 3));

      //* CHECK TOKEN
      // final token = await AppStorage.read(key: 'token');
      // if (token.isEmpty) {
      //   AppUtils.logger('token not exist');
      //   await NavigationService.pushNamedAndRemoveUntil(LoginView.routeName);
      //   return;
      // }

      //* CHECK TOKEN EXPIRED
      // final isTokenExpired = await AppUtils.checkTokenExpired();
      // if (!isTokenExpired) {
      //   AppUtils.logger('user authorized');
      //   await NavigationService.pushNamedAndRemoveUntil(MainView.routeName);
      //   return;
      // }

      //* DEFAULT ROUTES TO SIGN IN
      AppUtils.logger('token exist but expired');
      await NavigationService.pushNamedAndRemoveUntil(LoginView.routeName);
    } on Exception {
      await NavigationService.pushNamedAndRemoveUntil(LoginView.routeName);
    }
  }
}
