import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsible_development/database/activity_database.dart';
import 'package:responsible_development/models/activity_model.dart';
import 'package:responsible_development/utils/app_utils.dart';
import 'package:responsible_development/widgets/others/loading_indicator.dart';

class HistoryProvider extends ChangeNotifier {
  List<ActivityModel> _listMyHistory = [];

  List<ActivityModel> get listMyHistory => _listMyHistory;

  Future<void> getHistory(BuildContext context) async {
    context.loaderOverlay.show(
      widgetBuilder: (progress) => const LoadingIndicatorDefault(),
    );

    final data = await ActivityDatabase.selectData();
    _listMyHistory = data;
    _listMyHistory.sort(
      (a, b) => AppUtils.convertStringToDateTime(b.createdAt)
          .compareTo(AppUtils.convertStringToDateTime(a.createdAt)),
    );
    notifyListeners();

    if (context.mounted) {
      context.loaderOverlay.hide();
    }
  }

  Future<void> uploadData(BuildContext context) async {
    context.loaderOverlay.show(
      widgetBuilder: (progress) => const LoadingIndicatorDefault(),
    );

    final listDataUnUpload = await ActivityDatabase.selectDataUnUpload();

    for (final data in listDataUnUpload) {
      final temp = ActivityModel(
        createdAt: data.createdAt,
        date: data.date,
        description: data.description,
        finishTime: data.finishTime,
        id: data.id,
        isSynchronize: 1,
        projectId: data.projectId,
        projectName: data.projectName,
        startTime: data.startTime,
        updatedAt: data.updatedAt,
        userId: data.userId,
      );

      await ActivityDatabase.uploadData(temp);
    }

    final data = await ActivityDatabase.selectData();
    _listMyHistory = data;
    _listMyHistory.sort(
      (a, b) => AppUtils.convertStringToDateTime(b.createdAt)
          .compareTo(AppUtils.convertStringToDateTime(a.createdAt)),
    );
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    if (context.mounted) {
      context.loaderOverlay.hide();
    }
  }
}
