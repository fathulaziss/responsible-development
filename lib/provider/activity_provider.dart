import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsible_development/common/colors.dart';
import 'package:responsible_development/database/activity_database.dart';
import 'package:responsible_development/database/my_project_database.dart';
import 'package:responsible_development/database/user_database.dart';
import 'package:responsible_development/models/activity_model.dart';
import 'package:responsible_development/models/my_project_model.dart';
import 'package:responsible_development/models/user_model.dart';
import 'package:responsible_development/utils/app_utils.dart';
import 'package:responsible_development/widgets/others/loading_indicator.dart';
import 'package:responsible_development/widgets/others/show_dialog.dart';

class ActivityProvider extends ChangeNotifier {
  UserModel _user = UserModel();

  UserModel get user => _user;

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

      _user = await UserDatabase.selectData();
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

  Future<void> save(BuildContext context, String description) async {
    context.loaderOverlay.show(
      widgetBuilder: (progress) => const LoadingIndicatorDefault(),
    );

    final data = ActivityModel(
      id: AppUtils.generateActivityId(),
      date: AppUtils.convertDateTimeToString(DateTime.now()),
      projectId: selectedProject.project?.id ?? '',
      projectName: selectedProject.project?.name ?? '',
      startTime: AppUtils.convertTimeOfDayToString(selectedTimeStart),
      finishTime: AppUtils.convertTimeOfDayToString(selectedTimeFinish),
      description: description,
      userId: user.id ?? '',
      createdAt: AppUtils.convertDateTimeToString(DateTime.now()),
    );

    await ActivityDatabase.insertData(data);

    await Future.delayed(const Duration(seconds: 1));

    if (context.mounted) {
      context.loaderOverlay.hide();

      showToast(
        context,
        message: 'Data Berhasil Disimpan',
        backgroundColor: AppColor.success,
      );
    }
  }
}
