import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsible_development/database/project_database.dart';
import 'package:responsible_development/models/project_model.dart';
import 'package:responsible_development/widgets/others/loading_indicator.dart';

class ProjectProvider extends ChangeNotifier {
  List<ProjectModel> _listProject = [];

  List<ProjectModel> get listProject => _listProject;

  Future<void> getProject(BuildContext context) async {
    if (_listProject.isEmpty) {
      context.loaderOverlay.show(
        widgetBuilder: (progress) => const LoadingIndicatorDefault(),
      );

      final data = await ProjectDatabase.selectData();
      _listProject = data;
      await Future.delayed(const Duration(seconds: 1));
      notifyListeners();

      if (context.mounted) {
        context.loaderOverlay.hide();
      }
    }
  }
}
