import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsible_development/database/my_project_database.dart';
import 'package:responsible_development/database/user_database.dart';
import 'package:responsible_development/models/my_project_model.dart';
import 'package:responsible_development/widgets/others/loading_indicator.dart';

class ActivityProvider extends ChangeNotifier {
  List<MyProjectModel> _listMyProject = [];

  List<MyProjectModel> get listMyProject => _listMyProject;

  MyProjectModel _selectedProject = MyProjectModel();

  MyProjectModel get selectedProject => _selectedProject;

  Future<void> getMyProject(BuildContext context) async {
    if (_listMyProject.isEmpty) {
      context.loaderOverlay.show(
        widgetBuilder: (progress) => const LoadingIndicatorDefault(),
      );

      final user = await UserDatabase.selectData();
      final data = await MyProjectDatabase.selectData(user);
      _listMyProject = data;
      notifyListeners();

      if (context.mounted) {
        context.loaderOverlay.hide();
      }
    }

    _selectedProject = MyProjectModel();
  }

  void setSelectedProject(Object? value) {
    if (value != null) {
      final data = value as MyProjectModel;
      _selectedProject = data;
      notifyListeners();
    }
  }
}
