import 'package:flutter/material.dart';
import 'package:responsible_development/common/colors.dart';
import 'package:responsible_development/common/styles.dart';
import 'package:responsible_development/database/project_database.dart';
import 'package:responsible_development/models/project_model.dart';
import 'package:responsible_development/services/navigation_service.dart';
import 'package:responsible_development/utils/app_utils.dart';
import 'package:responsible_development/widgets/cards/card_custom.dart';
import 'package:responsible_development/widgets/inputs/input_search.dart';
import 'package:responsible_development/widgets/others/horizontal_space.dart';
import 'package:responsible_development/widgets/others/show_dialog.dart';

class ProjectSearchView extends StatefulWidget {
  const ProjectSearchView({super.key, this.listMyProject = const []});

  final List<ProjectModel> listMyProject;

  static String routeName = '/project-search';

  @override
  State<ProjectSearchView> createState() => _ProjectSearchViewState();
}

class _ProjectSearchViewState extends State<ProjectSearchView> {
  TextEditingController searchController = TextEditingController();
  List<ProjectModel> listProject = [];
  List<ProjectModel> listSearchProject = [];

  @override
  void initState() {
    getProject();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> getProject() async {
    final data = await ProjectDatabase.selectData();
    listProject = data;
    listSearchProject = data;
    setState(() {});
  }

  void searchProject(String keyword) {
    setState(() {
      final temp = <ProjectModel>[];

      if (keyword.isEmpty) {
        listSearchProject.addAll(listProject);
      }

      for (final item in listProject) {
        if (item.name!.toLowerCase().contains(keyword.toLowerCase())) {
          temp.add(item);
        }
      }

      listSearchProject = temp;
    });
  }

  void clearSearchProject() {
    searchController.clear();
    listSearchProject = listProject;
    AppUtils.dismissKeyboard();
    setState(() {});
  }

  void selectProject(ProjectModel value) {
    if (widget.listMyProject.contains(value)) {
      showToast(
        context,
        message: 'Proyek Ini Sudah Anda Pilih',
        backgroundColor: AppColor.warning,
      );
    } else {
      AppUtils.dismissKeyboard();
      NavigationService.pop(result: value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari Proyek RD'),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Flex(
          direction: Axis.vertical,
          children: [
            InputSearch(
              controller: searchController,
              onTapSuffixIcon: clearSearchProject,
              onChanged: searchProject,
              margin: const EdgeInsets.only(bottom: 12),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listSearchProject.length,
                itemBuilder: (context, index) {
                  final data = listSearchProject[index];

                  return InkWell(
                    onTap: () => selectProject(data),
                    child: CardCustom(
                      padding: const EdgeInsets.all(12),
                      margin: EdgeInsets.fromLTRB(
                        0,
                        data == listProject.first ? 0 : 12,
                        0,
                        data == listProject.last ? 45 : 0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${data.name}',
                                  style: textStyle.labelSmall,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Lokasi :'),
                                    const HorizontalSpace(width: 4),
                                    Expanded(
                                      child: Text(
                                        '${data.location!.isNotEmpty ? data.location?.join(', ') : '-'}',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => selectProject(data),
                            icon: const Icon(
                              Icons.add_box_rounded,
                              color: AppColor.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
