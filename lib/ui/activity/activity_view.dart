import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsible_development/models/my_project_model.dart';
import 'package:responsible_development/provider/activity_provider.dart';
import 'package:responsible_development/services/navigation_service.dart';
import 'package:responsible_development/ui/my_project/my_project_add_view.dart';
import 'package:responsible_development/widgets/buttons/button_primary.dart';
import 'package:responsible_development/widgets/inputs/input_date.dart';
import 'package:responsible_development/widgets/inputs/input_dropdown.dart';
import 'package:responsible_development/widgets/inputs/input_primary.dart';
import 'package:responsible_development/widgets/inputs/input_time.dart';
import 'package:responsible_development/widgets/others/input_dropdown_item.dart';
import 'package:responsible_development/widgets/others/show_dialog.dart';
import 'package:responsible_development/widgets/others/vertical_space.dart';

class ActivityView extends StatefulWidget {
  const ActivityView({super.key});

  static String routeName = '/activity';

  @override
  State<ActivityView> createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {
  final descriptionController = TextEditingController();

  @override
  void initState() {
    context.read<ActivityProvider>().getMyProject(context);
    super.initState();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ActivityProvider>(
      builder: (context, activityProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Aktivitas Proyek'),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          bottomNavigationBar: activityProvider.listMyProject.isEmpty
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(24),
                  child: ButtonPrimary(
                    label: 'Simpan',
                    onPressed: () {
                      if (activityProvider.selectedProject ==
                          const MyProjectModel()) {
                        showToast(
                          context,
                          message: 'Anda belum memilih Proyek RD',
                          backgroundColor: Colors.yellow.shade700,
                        );
                        return;
                      }

                      if (activityProvider.selectedDate == null) {
                        showToast(
                          context,
                          message: 'Anda belum memilih Tanggal',
                          backgroundColor: Colors.yellow.shade700,
                        );
                        return;
                      }

                      if (activityProvider.selectedTimeStart == null) {
                        showToast(
                          context,
                          message: 'Anda belum memilih Waktu Memulai Proyek',
                          backgroundColor: Colors.yellow.shade700,
                        );
                        return;
                      }

                      if (activityProvider.selectedTimeFinish == null) {
                        showToast(
                          context,
                          message:
                              'Anda belum memilih Waktu Menyelesaikan Proyek',
                          backgroundColor: Colors.yellow.shade700,
                        );
                        return;
                      }

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
                        desc: 'Apakah data yang Anda masukkan sudah sesuai ?',
                        onTapPositif: () {
                          activityProvider.save(
                            context,
                            descriptionController.text,
                          );
                        },
                      );
                    },
                  ),
                ),
          body: activityProvider.listMyProject.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ButtonPrimary(
                      label: 'Pilih Proyek RD',
                      onPressed: () async {
                        await NavigationService.pushNamed(
                          MyProjectAddView.routeName,
                        );
                        if (context.mounted) {
                          await activityProvider.getMyProject(context);
                        }
                      },
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const VerticalSpace(height: 12),
                        InputDropdown(
                          items: [
                            ...activityProvider.listMyProject.map(
                              (item) {
                                return DropdownMenuItem<MyProjectModel>(
                                  value: item,
                                  child: InputDropdownItem(
                                    value: '${item.project?.name}',
                                  ),
                                );
                              },
                            ),
                          ],
                          labelText: 'Proyek RD',
                          hintText: 'Pilih Proyek RD',
                          selectedItem:
                              '${activityProvider.selectedProject.project != null ? activityProvider.selectedProject.project?.name : ''}',
                          onChanged: activityProvider.setSelectedProject,
                        ),
                        const VerticalSpace(height: 12),
                        InputDate(
                          labelText: 'Tanggal',
                          hintText: 'Pilih Tanggal',
                          onChanged: activityProvider.setSelectedDate,
                        ),
                        InputTime(
                          labelText: 'Waktu Mulai',
                          hintText: 'Pilih waktu memulai aktivitas',
                          onChanged: (value) {
                            activityProvider.setSelectedTimeStart(value);
                            log('check Waktu Mulai : ${value?.hour.toString().padLeft(2, '0')}:${value?.minute.toString().padLeft(2, '0')}');
                          },
                        ),
                        InputTime(
                          labelText: 'Waktu Selesai',
                          hintText: 'Pilih waktu menyelesaikan aktivitas',
                          onChanged: (value) {
                            activityProvider.setSelectedTimeFinish(value);
                            log('check Waktu Selesai : ${value?.hour.toString().padLeft(2, '0')}:${value?.minute.toString().padLeft(2, '0')}');
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
        );
      },
    );
  }
}
