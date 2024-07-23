import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsible_development/common/styles.dart';
import 'package:responsible_development/database/activity_database.dart';
import 'package:responsible_development/models/activity_model.dart';
import 'package:responsible_development/provider/history_provider.dart';
import 'package:responsible_development/services/navigation_service.dart';
import 'package:responsible_development/ui/history/history_edit_view.dart';
import 'package:responsible_development/utils/app_utils.dart';
import 'package:responsible_development/widgets/buttons/button_primary.dart';
import 'package:responsible_development/widgets/cards/card_custom.dart';
import 'package:responsible_development/widgets/others/custom_divider.dart';
import 'package:responsible_development/widgets/others/preview_photo.dart';

class HistoryDetailView extends StatefulWidget {
  const HistoryDetailView({super.key, required this.data});

  final ActivityModel data;

  static String routeName = '/history-detail';

  @override
  State<HistoryDetailView> createState() => _HistoryDetailViewState();
}

class _HistoryDetailViewState extends State<HistoryDetailView> {
  ActivityModel activityData = const ActivityModel();

  @override
  void initState() {
    activityData = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detil Aktivitas'),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      bottomNavigationBar: activityData.isSynchronize == 1
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(24),
              child: ButtonPrimary(
                label: 'Edit',
                onPressed: () async {
                  final res = await NavigationService.pushNamed(
                    HistoryEditView.routeName,
                    arguments: activityData,
                  );

                  if (res != null) {
                    activityData = res;
                    await ActivityDatabase.updateData(activityData);
                    if (context.mounted) {
                      await context.read<HistoryProvider>().getHistory(context);
                    }

                    setState(() {});
                  }
                },
              ),
            ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(activityData.projectName, style: textStyle.labelMedium),
            const CustomDivider(),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Text('Aktivitas ID', style: textStyle.labelSmall),
                  Expanded(
                    child: Text(
                      activityData.id,
                      style: textStyle.bodyMedium,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Text('Tanggal Dibuat', style: textStyle.labelSmall),
                  Expanded(
                    child: Text(
                      activityData.createdAt,
                      style: textStyle.bodyMedium,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
            if (activityData.updatedAt.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Text('Tanggal Dirubah', style: textStyle.labelSmall),
                    Expanded(
                      child: Text(
                        activityData.updatedAt,
                        style: textStyle.bodyMedium,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Text('Waktu Mulai', style: textStyle.labelSmall),
                  Expanded(
                    child: Text(
                      activityData.startTime,
                      style: textStyle.bodyMedium,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Text('Waktu Selesai', style: textStyle.labelSmall),
                  Expanded(
                    child: Text(
                      activityData.finishTime,
                      style: textStyle.bodyMedium,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Text('Durasi', style: textStyle.labelSmall),
                  Expanded(
                    child: Text(
                      AppUtils.getDuration(
                        activityData.date,
                        activityData.startTime,
                        activityData.finishTime,
                      ),
                      style: textStyle.bodyMedium,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
            Text('Deskripsi', style: textStyle.labelSmall),
            CardCustom(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child:
                    Text(activityData.description, style: textStyle.bodyMedium),
              ),
            ),
            if (activityData.attachments.isNotEmpty)
              Text('Foto', style: textStyle.labelSmall),
            if (activityData.attachments.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: activityData.attachments.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: activityData.isSynchronize == 1
                            ? InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return PreviewPhoto(
                                        imagePath:
                                            activityData.attachments[index],
                                      );
                                    },
                                  );
                                },
                                child: Image.file(
                                  File(activityData.attachments[index]),
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return PreviewPhoto(
                                        imagePath:
                                            activityData.attachments[index],
                                      );
                                    },
                                  );
                                },
                                child: Image.file(
                                  File(activityData.attachments[index]),
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
