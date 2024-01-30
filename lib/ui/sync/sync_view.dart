import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsible_development/common/colors.dart';
import 'package:responsible_development/common/styles.dart';
import 'package:responsible_development/provider/sync_provider.dart';

class SyncView extends StatefulWidget {
  const SyncView({super.key});

  static String routeName = '/sync';

  @override
  State<SyncView> createState() => _SyncViewState();
}

class _SyncViewState extends State<SyncView> {
  @override
  void initState() {
    context.read<SyncProvider>().syncMasterData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SyncProvider>(
      builder: (context, syncProvider, _) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                    backgroundColor: AppColor.primary,
                  ),
                ),
                const SizedBox(height: 12),
                Text('Sync Data...', style: textStyle.titleSmall),
                Text(syncProvider.syncStatus, style: textStyle.bodyMedium),
              ],
            ),
          ),
        );
      },
    );
  }
}
