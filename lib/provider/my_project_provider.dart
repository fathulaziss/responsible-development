import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsible_development/common/colors.dart';
import 'package:responsible_development/database/my_project_database.dart';
import 'package:responsible_development/database/user_database.dart';
import 'package:responsible_development/models/my_project_model.dart';
import 'package:responsible_development/services/navigation_service.dart';
import 'package:responsible_development/widgets/others/loading_indicator.dart';
import 'package:responsible_development/widgets/others/show_dialog.dart';

class MyProjectProvider extends ChangeNotifier {
  List<MyProjectModel> _listMyProject = [];

  List<MyProjectModel> get listMyProject => _listMyProject;

  Future<void> getMyProject(BuildContext context) async {
    if (_listMyProject.isEmpty) {
      context.loaderOverlay.show(
        widgetBuilder: (progress) => const LoadingIndicatorDefault(),
      );

      final user = await UserDatabase.selectData();
      final data = await MyProjectDatabase.selectData(user);
      _listMyProject = data;
      await Future.delayed(const Duration(seconds: 1));
      notifyListeners();

      if (context.mounted) {
        context.loaderOverlay.hide();
      }
    }
  }

  Future<void> setMyProject(
    BuildContext context, {
    required List<MyProjectModel> data,
  }) async {
    context.loaderOverlay.show(
      widgetBuilder: (progress) => const LoadingIndicatorDefault(),
    );

    _listMyProject = data;
    await MyProjectDatabase.insertData(data);
    await Future.delayed(const Duration(seconds: 1));
    notifyListeners();

    if (context.mounted) {
      context.loaderOverlay.hide();

      showToast(
        context,
        message: 'Data Proyek RD Berhasil Disimpan',
        backgroundColor: AppColor.success,
      );
    }

    NavigationService.pop();
  }
}
