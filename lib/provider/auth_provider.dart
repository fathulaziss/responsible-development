import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsible_development/common/colors.dart';
import 'package:responsible_development/models/login_data_model.dart';
import 'package:responsible_development/repository/auth_repository.dart';
import 'package:responsible_development/services/navigation_service.dart';
import 'package:responsible_development/ui/login/login_view.dart';
import 'package:responsible_development/ui/main/main_view.dart';
import 'package:responsible_development/utils/app_utils.dart';
import 'package:responsible_development/widgets/others/loading_indicator.dart';
import 'package:responsible_development/widgets/others/show_dialog.dart';

class AuthProvider extends ChangeNotifier {
  Future<bool> validateFormLogin(
    BuildContext context, {
    required TextEditingController usernameController,
    required TextEditingController passwordController,
  }) async {
    if (usernameController.text.isEmpty && passwordController.text.isEmpty) {
      if (context.mounted) {
        showToast(
          context,
          message: 'Masukkan Nama Pengguna dan Kata Sandi Anda',
          backgroundColor: AppColor.warning,
        );
        return false;
      }
    }

    if (usernameController.text.isEmpty) {
      if (context.mounted) {
        showToast(
          context,
          message: 'Masukkan Nama Pengguna Anda',
          backgroundColor: AppColor.warning,
        );
        return false;
      }
    }

    if (passwordController.text.isEmpty) {
      if (context.mounted) {
        showToast(
          context,
          message: 'Masukkan Kata Sandi Anda',
          backgroundColor: AppColor.warning,
        );
        return false;
      }
    }

    return true;
  }

  Future<void> login(
    BuildContext context, {
    required TextEditingController usernameController,
    required TextEditingController passwordController,
  }) async {
    AppUtils.dismissKeyboard();

    final isFormValid = await validateFormLogin(
      context,
      usernameController: usernameController,
      passwordController: passwordController,
    );

    if (isFormValid) {
      if (context.mounted) {
        context.loaderOverlay.show(
          widgetBuilder: (progress) => const LoadingIndicatorDefault(),
        );
      }

      await AuthRepository.login(
        username: usernameController.text,
        password: passwordController.text,
        onSuccess: (LoginDataModel data) async {
          if (context.mounted) {
            context.loaderOverlay.hide();
          }

          await NavigationService.pushReplacementNamed(MainView.routeName);
        },
        onError: (String errorMessage) {
          context.loaderOverlay.hide();
          showDialogError(context, title: 'Login Gagal', desc: errorMessage);
        },
      );
    }
  }

  Future<void> logout(BuildContext context) async {
    if (context.mounted) {
      context.loaderOverlay.show(
        widgetBuilder: (progress) => const LoadingIndicatorDefault(),
      );
    }

    await AuthRepository.logout(
      onSuccess: (String successMessage) {
        context.loaderOverlay.hide();
        showToast(
          context,
          message: successMessage,
          backgroundColor: Colors.green,
        );
        NavigationService.pushNamedAndRemoveUntil(LoginView.routeName);
      },
      onError: (String errorMessage) {
        context.loaderOverlay.hide();
        showDialogError(context, title: 'Logout Gagal', desc: errorMessage);
      },
    );
  }
}
