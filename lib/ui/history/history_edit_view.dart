import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsible_development/models/activity_model.dart';
import 'package:responsible_development/services/navigation_service.dart';
import 'package:responsible_development/utils/app_utils.dart';
import 'package:responsible_development/widgets/buttons/button_primary.dart';
import 'package:responsible_development/widgets/inputs/input_primary.dart';
import 'package:responsible_development/widgets/inputs/input_time.dart';
import 'package:responsible_development/widgets/others/show_dialog.dart';

class HistoryEditView extends StatefulWidget {
  const HistoryEditView({super.key, required this.data});

  final ActivityModel data;

  static String routeName = '/history-edit';

  @override
  State<HistoryEditView> createState() => _HistoryEditViewState();
}

class _HistoryEditViewState extends State<HistoryEditView> {
  ActivityModel activityData = const ActivityModel();
  TextEditingController projectController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeStartController = TextEditingController();
  TextEditingController timeFinishController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TimeOfDay? selectedTimeStart;
  TimeOfDay? selectedTimeFinish;

  @override
  void initState() {
    activityData = widget.data;
    projectController.text = activityData.projectName;
    dateController.text = DateFormat('dd/MM/yyyy')
        .format(AppUtils.convertStringToDateTime(activityData.date));
    selectedTimeStart =
        AppUtils.convertStringToTimeOfDay(activityData.startTime);
    timeStartController.text = activityData.startTime;
    selectedTimeFinish =
        AppUtils.convertStringToTimeOfDay(activityData.finishTime);
    timeFinishController.text = activityData.finishTime;
    descriptionController.text = activityData.description;
    super.initState();
  }

  @override
  void dispose() {
    projectController.dispose();
    dateController.dispose();
    timeStartController.dispose();
    timeFinishController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop == false) {
          showDialogOption(
            context,
            title: 'Konfirmasi',
            desc:
                'Data belum tersimpan, apakah Anda yakin untuk keluar dari halaman ini ?',
            onTapPositif: NavigationService.pop,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Aktivitas'),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(24),
          child: ButtonPrimary(
            label: 'Simpan',
            onPressed: () {
              if (descriptionController.text.isEmpty) {
                showToast(
                  context,
                  message: 'Anda belum mengisi Deskripsi',
                  backgroundColor: Colors.yellow.shade700,
                );
                return;
              }

              showDialogOption(
                context,
                title: 'Konfirmasi',
                desc: 'Apakah data yang Anda edit sudah sesuai ?',
                onTapPositif: () {
                  final activityDataUpdate = ActivityModel(
                    createdAt: activityData.createdAt,
                    date: activityData.date,
                    description: descriptionController.text,
                    finishTime:
                        AppUtils.convertTimeOfDayToString(selectedTimeFinish),
                    id: activityData.id,
                    isSynchronize: activityData.isSynchronize,
                    projectId: activityData.projectId,
                    projectName: activityData.projectName,
                    startTime:
                        AppUtils.convertTimeOfDayToString(selectedTimeStart),
                    updatedAt: AppUtils.convertDateTimeToString(DateTime.now()),
                    userId: activityData.userId,
                  );
                  NavigationService.pop(result: activityDataUpdate);
                },
              );
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                InputPrimary(
                  labelText: 'Proyek RD',
                  readOnly: true,
                  controller: projectController,
                ),
                InputPrimary(
                  labelText: 'Tanggal',
                  readOnly: true,
                  controller: dateController,
                ),
                InputTime(
                  labelText: 'Waktu Mulai',
                  hintText: 'Pilih waktu memulai aktivitas',
                  controller: timeStartController,
                  onChanged: (value) {
                    if (value != null) {
                      selectedTimeStart = value;
                    }

                    setState(() {});
                    log('check Waktu Mulai : ${AppUtils.convertTimeOfDayToString(selectedTimeStart)}');
                  },
                ),
                InputTime(
                  labelText: 'Waktu Selesai',
                  hintText: 'Pilih waktu menyelesaikan aktivitas',
                  controller: timeFinishController,
                  onChanged: (value) {
                    if (value != null) {
                      selectedTimeFinish = value;
                    }

                    setState(() {});
                    log('check Waktu Selesai : ${AppUtils.convertTimeOfDayToString(selectedTimeFinish)}');
                  },
                ),
                InputPrimary(
                  controller: descriptionController,
                  labelText: 'Deskripsi',
                  hintText: 'Masukkan Deskripsi',
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  validator: (value) => null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
