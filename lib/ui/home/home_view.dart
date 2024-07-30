import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsible_development/common/styles.dart';
import 'package:responsible_development/models/my_project_model.dart';
import 'package:responsible_development/provider/home_provider.dart';
import 'package:responsible_development/provider/utility_provider.dart';
import 'package:responsible_development/services/navigation_service.dart';
import 'package:responsible_development/ui/my_project/my_project_add_view.dart';
import 'package:responsible_development/widgets/buttons/button_primary.dart';
import 'package:responsible_development/widgets/inputs/input_dropdown.dart';
import 'package:responsible_development/widgets/others/custom_divider.dart';
import 'package:responsible_development/widgets/others/custom_table.dart';
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
    return Consumer<UtilityProvider>(
      builder: (context, utilityProvider, _) {
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                              ...homeProvider.listPeriode.map(
                                (item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: InputDropdownItem(
                                      value: item,
                                    ),
                                  );
                                },
                              ),
                            ],
                            labelText: 'Periode Proyek RD',
                            hintText: 'Pilih Periode Proyek RD',
                            selectedItem:
                                homeProvider.selectedPeriode.isNotEmpty
                                    ? homeProvider.selectedPeriode
                                    : '',
                            onChanged: homeProvider.setSelectedPeriode,
                          ),
                          const VerticalSpace(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Bobot KPI',
                                  style: textStyle.labelSmall,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  ' : ${homeProvider.selectedProject.percentage!.toStringAsFixed(0)}%',
                                  style: textStyle.labelSmall,
                                ),
                              ),
                            ],
                          ),
                          const CustomDivider(),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Bobot Jam Kontribusi',
                                  style: textStyle.labelSmall,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  ' : ${((homeProvider.selectedProject.percentage! / 15) * 24).toStringAsFixed(0)} Jam/Bulan',
                                  style: textStyle.labelSmall,
                                ),
                              ),
                            ],
                          ),
                          const CustomDivider(),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Average Aktual Jam Kontribusi/Bulan',
                                  style: textStyle.labelSmall,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  ' : ${homeProvider.averageAktualJamKontribusi.toStringAsFixed(1)}',
                                  style: textStyle.labelSmall,
                                ),
                              ),
                            ],
                          ),
                          const CustomDivider(),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Total Aktual Jam Kontribusi',
                                  style: textStyle.labelSmall,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  ' : ${homeProvider.totalAktualJamKontribusi.toStringAsFixed(1)}',
                                  style: textStyle.labelSmall,
                                ),
                              ),
                            ],
                          ),
                          const CustomDivider(),
                          const VerticalSpace(height: 12),
                          CustomTable(
                            labelLeft: 'Bulan',
                            labelRight: 'Aktual Jam Kontribusi',
                            decorationLeft: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: utilityProvider.isDarkTheme ||
                                          MediaQuery.of(context)
                                                  .platformBrightness ==
                                              Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                top: BorderSide(
                                  color: utilityProvider.isDarkTheme ||
                                          MediaQuery.of(context)
                                                  .platformBrightness ==
                                              Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                            decorationRight: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: utilityProvider.isDarkTheme ||
                                          MediaQuery.of(context)
                                                  .platformBrightness ==
                                              Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                right: BorderSide(
                                  color: utilityProvider.isDarkTheme ||
                                          MediaQuery.of(context)
                                                  .platformBrightness ==
                                              Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                top: BorderSide(
                                  color: utilityProvider.isDarkTheme ||
                                          MediaQuery.of(context)
                                                  .platformBrightness ==
                                              Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  CustomTable(
                                    labelLeft: 'Januari',
                                    labelRight: homeProvider
                                        .aktualJamKontribusiJanuari
                                        .toStringAsFixed(1),
                                    decorationLeft: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        left: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    decorationRight: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        left: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        right: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  CustomTable(
                                    labelLeft: 'Februari',
                                    labelRight: homeProvider
                                        .aktualJamKontribusiFebruari
                                        .toStringAsFixed(1),
                                    decorationLeft: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        left: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    decorationRight: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        left: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        right: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  CustomTable(
                                    labelLeft: 'Maret',
                                    labelRight: homeProvider
                                        .aktualJamKontribusiMaret
                                        .toStringAsFixed(1),
                                    decorationLeft: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        left: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    decorationRight: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        left: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        right: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  CustomTable(
                                    labelLeft: 'April',
                                    labelRight: homeProvider
                                        .aktualJamKontribusiApril
                                        .toStringAsFixed(1),
                                    decorationLeft: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        left: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    decorationRight: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        left: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        right: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  CustomTable(
                                    labelLeft: 'Mei',
                                    labelRight: homeProvider
                                        .aktualJamKontribusiMei
                                        .toStringAsFixed(1),
                                    decorationLeft: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        left: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    decorationRight: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        left: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        right: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  CustomTable(
                                    labelLeft: 'Juni',
                                    labelRight: homeProvider
                                        .aktualJamKontribusiJuni
                                        .toStringAsFixed(1),
                                    decorationLeft: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        left: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    decorationRight: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        left: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        right: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  CustomTable(
                                    labelLeft: 'Juli',
                                    labelRight: homeProvider
                                        .aktualJamKontribusiJuli
                                        .toStringAsFixed(1),
                                    decorationLeft: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        left: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    decorationRight: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        left: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        right: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  CustomTable(
                                    labelLeft: 'Agustus',
                                    labelRight: homeProvider
                                        .aktualJamKontribusiAgustus
                                        .toStringAsFixed(1),
                                    decorationLeft: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        left: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    decorationRight: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        left: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        right: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  CustomTable(
                                    labelLeft: 'September',
                                    labelRight: homeProvider
                                        .aktualJamKontribusiSeptember
                                        .toStringAsFixed(1),
                                    decorationLeft: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        left: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    decorationRight: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        left: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        right: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  CustomTable(
                                    labelLeft: 'Oktober',
                                    labelRight: homeProvider
                                        .aktualJamKontribusiOktober
                                        .toStringAsFixed(1),
                                    decorationLeft: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        left: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    decorationRight: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        left: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        right: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  CustomTable(
                                    labelLeft: 'November',
                                    labelRight: homeProvider
                                        .aktualJamKontribusiNovember
                                        .toStringAsFixed(1),
                                    decorationLeft: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        left: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    decorationRight: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        left: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        right: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  CustomTable(
                                    labelLeft: 'Desember',
                                    labelRight: homeProvider
                                        .aktualJamKontribusiDesember
                                        .toStringAsFixed(1),
                                    decorationLeft: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        left: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        bottom: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    decorationRight: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        left: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        right: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        bottom: BorderSide(
                                          color: utilityProvider.isDarkTheme ||
                                                  MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const VerticalSpace(height: 45),
                        ],
                      ),
                    ),
            );
          },
        );
      },
    );
  }
}
