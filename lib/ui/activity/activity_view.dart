import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsible_development/common/colors.dart';
import 'package:responsible_development/common/styles.dart';
import 'package:responsible_development/provider/activity_provider.dart';
import 'package:responsible_development/services/navigation_service.dart';
import 'package:responsible_development/ui/my_project/my_project_add_view.dart';
import 'package:responsible_development/widgets/buttons/button_primary.dart';
import 'package:responsible_development/widgets/others/custom_divider.dart';

class ActivityView extends StatefulWidget {
  const ActivityView({super.key});

  static String routeName = '/activity';

  @override
  State<ActivityView> createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {
  @override
  void initState() {
    context.read<ActivityProvider>().getMyProject(context);
    super.initState();
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
              : Flex(
                  direction: Axis.vertical,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: activityProvider.listMyProject.length,
                        itemBuilder: (context, index) {
                          final data = activityProvider.listMyProject[index];
                          return Padding(
                            padding: EdgeInsets.fromLTRB(
                              12,
                              12,
                              12,
                              data == activityProvider.listMyProject.last
                                  ? 45
                                  : 0,
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
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
        );
      },
    );
  }
}
