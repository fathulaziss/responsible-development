import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsible_development/database/project_database.dart';
import 'package:responsible_development/models/project_model.dart';
import 'package:responsible_development/provider/auth_provider.dart';
import 'package:responsible_development/repository/sync_repository.dart';
import 'package:responsible_development/services/navigation_service.dart';
import 'package:responsible_development/ui/main/main_view.dart';
import 'package:responsible_development/widgets/others/show_dialog.dart';

class SyncProvider extends ChangeNotifier {
  String _syncStatus = '';

  String get syncStatus => _syncStatus;

  Future<void> syncMasterData(BuildContext context) async {
    _syncStatus = 'Sync Data RD Project';

    await SyncRepository.syncRDProject(
      onSuccess: (List<ProjectModel> data) async {
        await ProjectDatabase.insertData(data);

        await NavigationService.pushReplacementNamed(MainView.routeName);
      },
      onError: (String errorMessage) {
        onErrorSynchronize(
          context: context,
          errorMessage: 'Sync Data RD Project Gagal : $errorMessage',
        );
      },
    );
  }

  void onErrorSynchronize({
    required BuildContext context,
    required String errorMessage,
  }) {
    showDialogError(
      context,
      title: 'Gagal Melakukan Sync',
      desc: errorMessage,
      onTap: () async {
        await context.read<AuthProvider>().logout(context);
      },
    );
    return;
  }
}
