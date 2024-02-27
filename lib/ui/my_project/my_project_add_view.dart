import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsible_development/common/colors.dart';
import 'package:responsible_development/common/styles.dart';
import 'package:responsible_development/database/user_database.dart';
import 'package:responsible_development/models/my_project_model.dart';
import 'package:responsible_development/models/project_model.dart';
import 'package:responsible_development/models/user_model.dart';
import 'package:responsible_development/provider/my_project_provider.dart';
import 'package:responsible_development/services/navigation_service.dart';
import 'package:responsible_development/ui/project/project_search_view.dart';
import 'package:responsible_development/utils/app_utils.dart';
import 'package:responsible_development/widgets/buttons/button_primary.dart';
import 'package:responsible_development/widgets/buttons/button_secondary.dart';
import 'package:responsible_development/widgets/inputs/input_primary.dart';
import 'package:responsible_development/widgets/inputs/input_search.dart';
import 'package:responsible_development/widgets/others/custom_divider.dart';
import 'package:responsible_development/widgets/others/horizontal_space.dart';
import 'package:responsible_development/widgets/others/show_dialog.dart';
import 'package:responsible_development/widgets/others/vertical_space.dart';

class MyProjectAddView extends StatefulWidget {
  const MyProjectAddView({super.key});

  static String routeName = '/my-project-add';

  @override
  State<MyProjectAddView> createState() => _MyProjectAddViewState();
}

class _MyProjectAddViewState extends State<MyProjectAddView> {
  UserModel? user;
  TextEditingController percentageController = TextEditingController();
  List<MyProjectModel> listMyProject = [];
  ProjectModel? selectedProject;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  void dispose() {
    percentageController.dispose();
    super.dispose();
  }

  Future<void> getUser() async {
    final data = await UserDatabase.selectData();
    user = data;
    setState(() {});
  }

  bool checkTotalPercentageRD() {
    final listPercentage =
        listMyProject.map((e) => e.percentage ?? 0.0).toList();
    var totalPercentage = 0.0;
    for (final item in listPercentage) {
      totalPercentage = totalPercentage + item;
    }

    if (percentageController.text.isNotEmpty) {
      if (double.parse(percentageController.text).roundToDouble() +
              totalPercentage.roundToDouble() <=
          15.0) {
        return true;
      } else {
        return false;
      }
    } else if (percentageController.text.isEmpty) {
      if (totalPercentage.roundToDouble() < 15.0) {
        return true;
      } else {
        return false;
      }
    }

    return false;
  }

  void addProject() {
    listMyProject.add(
      MyProjectModel(
        userId: user?.id,
        percentage: double.tryParse(percentageController.text),
        project: selectedProject,
      ),
    );

    showToast(
      context,
      message: 'Proyek Berhasil Ditambahkan',
      backgroundColor: AppColor.success,
    );

    percentageController.clear();
    selectedProject = null;
    AppUtils.dismissKeyboard();
    setState(() {});
  }

  void removeProject(MyProjectModel data) {
    listMyProject.remove(data);

    showToast(
      context,
      message: 'Proyek Berhasil Dihapus',
      backgroundColor: AppColor.success,
    );

    percentageController.clear();
    selectedProject = null;
    AppUtils.dismissKeyboard();
    setState(() {});
  }

  bool validateForm() {
    if (selectedProject == null) {
      showToast(
        context,
        message: 'Anda Belum Memilih Proyek',
        backgroundColor: AppColor.warning,
      );
      return false;
    }

    if (percentageController.text.isEmpty) {
      showToast(
        context,
        message: 'Anda Belum Mengisi Persentase Proyek',
        backgroundColor: AppColor.warning,
      );
      return false;
    }

    if (checkTotalPercentageRD() == false) {
      showToast(
        context,
        message: 'Total Persentase Proyek Anda Tidak Boleh Melebihi 15%',
        backgroundColor: AppColor.warning,
      );
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProjectProvider>(
      builder: (context, myProjectProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Pilih Proyek RD'),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Expanded(
                  child: listMyProject.isEmpty
                      ? Center(
                          child: Text(
                            'Anda Belum Menambahkan Proyek',
                            style: textStyle.bodyMedium,
                          ),
                        )
                      : Flex(
                          direction: Axis.vertical,
                          children: [
                            Text(
                              'Daftar Proyek RD Anda',
                              style: textStyle.labelSmall,
                            ),
                            const VerticalSpace(height: 8),
                            Expanded(
                              child: ListView.builder(
                                itemCount: listMyProject.length,
                                itemBuilder: (context, index) {
                                  final data = listMyProject[index];
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Proyek RD ${index + 1} :',
                                                  style: textStyle.labelSmall,
                                                ),
                                                Text(
                                                  data.project?.name ?? '',
                                                  style: textStyle.labelSmall!
                                                      .copyWith(
                                                    color: AppColor.primary,
                                                  ),
                                                ),
                                                Text(
                                                  'Persentase : ${data.percentage!.toStringAsFixed(0)}%',
                                                  style: textStyle.labelSmall!
                                                      .copyWith(
                                                    color: AppColor.primary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const HorizontalSpace(width: 4),
                                          ButtonSecondary(
                                            label: 'Hapus',
                                            onPressed: () =>
                                                removeProject(data),
                                          ),
                                        ],
                                      ),
                                      const CustomDivider(),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                ),
                if (checkTotalPercentageRD()) const CustomDivider(),
                if (checkTotalPercentageRD())
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pilih Proyek RD : ',
                            style: textStyle.bodyMedium,
                          ),
                          if (selectedProject == null)
                            InkWell(
                              onTap: () async {
                                final data = await NavigationService.pushNamed(
                                  ProjectSearchView.routeName,
                                  arguments: List<ProjectModel>.from(
                                    listMyProject.map((e) => e.project),
                                  ),
                                );
                                if (data != null) {
                                  selectedProject = data;
                                  setState(() {});
                                }
                              },
                              child: const InputSearch(
                                margin: EdgeInsets.only(top: 4),
                                enabled: false,
                              ),
                            ),
                          if (selectedProject != null)
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        selectedProject?.name ?? '',
                                        style: textStyle.labelSmall!
                                            .copyWith(color: AppColor.primary),
                                      ),
                                    ),
                                    const HorizontalSpace(width: 8),
                                    ButtonSecondary(
                                      label: 'Edit',
                                      onPressed: () async {
                                        final data =
                                            await NavigationService.pushNamed(
                                          ProjectSearchView.routeName,
                                        );
                                        if (data != null) {
                                          selectedProject = data;
                                          setState(() {});
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                const CustomDivider(),
                              ],
                            ),
                          if (selectedProject != null)
                            InputPrimary(
                              labelText: 'Persentase Proyek RD :',
                              hintText: 'Masukkan Persentase',
                              validatorText: 'Persentase Tidak Boleh Kosong',
                              controller: percentageController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                  ',',
                                  replacementString: '.',
                                ),
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d*'),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                if (checkTotalPercentageRD())
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: ButtonPrimary(
                      label: 'Tambahkan Proyek',
                      onPressed: () {
                        if (validateForm()) {
                          addProject();
                        }
                      },
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: ButtonPrimary(
                      label: 'Simpan',
                      onPressed: () => myProjectProvider.setMyProject(
                        context,
                        data: listMyProject,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
