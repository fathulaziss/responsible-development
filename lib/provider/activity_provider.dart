import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsible_development/database/my_project_database.dart';
import 'package:responsible_development/database/user_database.dart';
import 'package:responsible_development/models/my_project_model.dart';
import 'package:responsible_development/widgets/others/loading_indicator.dart';

class ActivityProvider extends ChangeNotifier {
  List<MyProjectModel> _listMyProject = [];

  List<MyProjectModel> get listMyProject => _listMyProject;

  MyProjectModel _selectedProject = const MyProjectModel();

  MyProjectModel get selectedProject => _selectedProject;

  DateTime? _selectedDate;

  DateTime? get selectedDate => _selectedDate;

  TimeOfDay? _selectedTimeStart;

  TimeOfDay? get selectedTimeStart => _selectedTimeStart;

  TimeOfDay? _selectedTimeFinish;

  TimeOfDay? get selectedTimeFinish => _selectedTimeFinish;

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

    _selectedProject = const MyProjectModel();
    _selectedDate = null;
    _selectedTimeStart = null;
    _selectedTimeFinish = null;
  }

  void setSelectedProject(Object? value) {
    if (value != null) {
      final data = value as MyProjectModel;
      _selectedProject = data;
      notifyListeners();
    }
  }

  void setSelectedDate(DateTime? value) {
    if (value != null) {
      _selectedDate = value;
      notifyListeners();
    }
  }

  void setSelectedTimeStart(TimeOfDay? value) {
    if (value != null) {
      _selectedTimeStart = value;
      notifyListeners();
    }
  }

  void setSelectedTimeFinish(TimeOfDay? value) {
    if (value != null) {
      _selectedTimeFinish = value;
      notifyListeners();
    }
  }
}
