import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsible_development/common/styles.dart';
import 'package:responsible_development/database/project_database.dart';
import 'package:responsible_development/models/my_project_model.dart';
import 'package:responsible_development/models/project_model.dart';
import 'package:responsible_development/provider/my_project_provider.dart';
import 'package:responsible_development/widgets/buttons/button_primary.dart';
import 'package:responsible_development/widgets/inputs/input_primary.dart';
import 'package:responsible_development/widgets/inputs/input_search_dropdown.dart';
import 'package:responsible_development/widgets/others/custom_divider.dart';
import 'package:responsible_development/widgets/others/input_search_dropdown_item.dart';
import 'package:responsible_development/widgets/others/vertical_space.dart';

class MyProjectAddView extends StatefulWidget {
  const MyProjectAddView({super.key});

  static String routeName = '/my-project-add';

  @override
  State<MyProjectAddView> createState() => _MyProjectAddViewState();
}

class _MyProjectAddViewState extends State<MyProjectAddView> {
  TextEditingController searchController = TextEditingController();
  TextEditingController percentageController = TextEditingController();
  List<MyProjectModel> listMyProject = [];
  List<ProjectModel> listProject = [];
  ProjectModel? selectedProject;

  @override
  void initState() {
    getProject();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    percentageController.dispose();
    super.dispose();
  }

  Future<void> getProject() async {
    final data = await ProjectDatabase.selectData();
    listProject = data;
    setState(() {});
  }

  Future<List<ProjectModel>> searchProject(String keyword) async {
    final searchList = <ProjectModel>[];
    for (var i = 0; i < listProject.length; i++) {
      final name = listProject[i].name;

      if (name!.toLowerCase().contains(keyword.toLowerCase())) {
        searchList.add(listProject[i]);
      }
    }

    if (searchController.text != selectedProject?.name) {
      selectedProject = null;
      setState(() {});
    }

    await Future.delayed(const Duration(milliseconds: 300));

    return searchList;
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
                  child: myProjectProvider.listMyProject.isEmpty
                      ? Center(
                          child: Text(
                            'Anda Belum Menambahkan Proyek',
                            style: textStyle.bodyMedium,
                          ),
                        )
                      : const SizedBox(),
                ),
                const CustomDivider(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        InputSearchDropdown(
                          controller: searchController,
                          hintText: 'Pencarian',
                          labelText: 'Pilih Proyek RD',
                          preffixIcon: Icons.search,
                          suffixIcon: Icons.cancel,
                          onTapSuffixIcon: () {
                            searchController.clear();
                            percentageController.clear();
                            selectedProject = null;
                            setState(() {});
                          },
                          itemBuilder: (context, value) {
                            final data = value as ProjectModel;
                            return InputSearchDropdonwItem(
                              child: Text(
                                '${data.name}',
                                style: textStyle.labelSmall!
                                    .copyWith(color: Colors.white),
                              ),
                            );
                          },
                          suggestionsCallback: searchProject,
                          onSelected: (value) {
                            final data = value as ProjectModel;
                            searchController.text = value.name ?? '';
                            selectedProject = data;
                            percentageController.clear();
                            setState(() {});
                          },
                        ),
                        if (selectedProject != null)
                          InputPrimary(
                            labelText: 'Persentase Proyek RD',
                            hintText: 'Masukkan Persentase',
                            validatorText: 'Persentase Tidak Boleh Kosong',
                            controller: percentageController,
                            keyboardType: const TextInputType.numberWithOptions(
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
                const VerticalSpace(height: 12),
                ButtonPrimary(label: 'Tambahkan Proyek', onPressed: () {}),
              ],
            ),
          ),
        );
      },
    );
  }
}
