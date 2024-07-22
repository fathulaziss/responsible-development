import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsible_development/common/styles.dart';
import 'package:responsible_development/models/my_project_model.dart';
import 'package:responsible_development/provider/home_provider.dart';
import 'package:responsible_development/services/navigation_service.dart';
import 'package:responsible_development/ui/my_project/my_project_add_view.dart';
import 'package:responsible_development/widgets/buttons/button_primary.dart';
import 'package:responsible_development/widgets/inputs/input_dropdown.dart';
import 'package:responsible_development/widgets/others/input_dropdown_item.dart';
import 'package:responsible_development/widgets/others/vertical_space.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static String routeName = '/home';
  static String title = 'Beranda';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    context.read<HomeProvider>().getMyProject(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Ringkasan Aktivitas'),
            centerTitle: true,
          ),
          body: homeProvider.listMyProject.isEmpty
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
                          await context
                              .read<HomeProvider>()
                              .getMyProject(context);
                        }
                      },
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      const VerticalSpace(height: 12),
                      InputDropdown(
                        items: [
                          ...homeProvider.listMyProject.map(
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
                            '${homeProvider.selectedProject.project != null ? homeProvider.selectedProject.project?.name : ''}',
                        onChanged: homeProvider.setSelectedProject,
                      ),
                      const VerticalSpace(height: 12),
                      InputDropdown(
                        items: [
                          ...homeProvider.listMyProject.map(
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
                        labelText: 'Periode Proyek RD',
                        hintText: 'Pilih Periode Proyek RD',
                        selectedItem:
                            '${homeProvider.selectedProject.project != null ? homeProvider.selectedProject.project?.name : ''}',
                        onChanged: homeProvider.setSelectedProject,
                      ),
                      const VerticalSpace(height: 12),
                      Text(
                        'Bobot KPI : ${homeProvider.selectedProject.percentage!.toStringAsFixed(0)}%',
                        style: textStyle.labelSmall,
                      ),
                      Text(
                        'Bobot Jam Kontribusi : ${homeProvider.selectedProject.percentage! == 5 ? '8' : homeProvider.selectedProject.percentage! == 10 ? '16' : '24'} Jam/Bulan',
                        style: textStyle.labelSmall,
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
