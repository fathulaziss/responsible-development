import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsible_development/common/colors.dart';
import 'package:responsible_development/common/styles.dart';
import 'package:responsible_development/provider/my_project_provider.dart';
import 'package:responsible_development/services/navigation_service.dart';
import 'package:responsible_development/ui/my_project/my_project_add_view.dart';
import 'package:responsible_development/widgets/buttons/button_primary.dart';
import 'package:responsible_development/widgets/others/custom_divider.dart';

class MyProjectView extends StatefulWidget {
  const MyProjectView({super.key});

  static String routeName = '/my-project';

  @override
  State<MyProjectView> createState() => _MyProjectViewState();
}

class _MyProjectViewState extends State<MyProjectView> {
  @override
  void initState() {
    context.read<MyProjectProvider>().getMyProject(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProjectProvider>(
      builder: (context, myProjectProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Proyek RD Saya'),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: myProjectProvider.listMyProject.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ButtonPrimary(
                      label: 'Pilih Proyek RD',
                      onPressed: () {
                        NavigationService.pushNamed(MyProjectAddView.routeName);
                      },
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: myProjectProvider.listMyProject.length,
                  itemBuilder: (context, index) {
                    final data = myProjectProvider.listMyProject[index];
                    return Padding(
                      padding: EdgeInsets.fromLTRB(
                        12,
                        12,
                        12,
                        data == myProjectProvider.listMyProject.last ? 45 : 0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Proyek RD ${index + 1} :',
                            style: textStyle.labelSmall,
                          ),
                          Text(
                            data.project?.name ?? '',
                            style: textStyle.labelSmall!.copyWith(
                              color: AppColor.primary,
                            ),
                          ),
                          Text(
                            'Persentase : ${data.percentage!.toStringAsFixed(0)}%',
                            style: textStyle.labelSmall!.copyWith(
                              color: AppColor.primary,
                            ),
                          ),
                          const CustomDivider(),
                        ],
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
