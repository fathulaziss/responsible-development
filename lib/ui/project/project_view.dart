import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsible_development/common/styles.dart';
import 'package:responsible_development/provider/project_provider.dart';
import 'package:responsible_development/services/navigation_service.dart';
import 'package:responsible_development/ui/project/project_detail_view.dart';
import 'package:responsible_development/widgets/cards/card_custom.dart';
import 'package:responsible_development/widgets/others/horizontal_space.dart';

class ProjectView extends StatefulWidget {
  const ProjectView({super.key});

  static String routeName = '/project';
  static String title = 'Proyek';

  @override
  State<ProjectView> createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> {
  @override
  void initState() {
    context.read<ProjectProvider>().getProject(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectProvider>(
      builder: (context, projectProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Daftar Proyek'),
            centerTitle: true,
          ),
          body: projectProvider.listProject.isNotEmpty
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: projectProvider.listProject.length,
                  itemBuilder: (context, index) {
                    final data = projectProvider.listProject[index];
                    return InkWell(
                      onTap: () {
                        NavigationService.pushNamed(
                          ProjectDetailView.routeName,
                          arguments: data,
                        );
                      },
                      child: CardCustom(
                        padding: const EdgeInsets.all(12),
                        margin: EdgeInsets.fromLTRB(
                          12,
                          12,
                          12,
                          data == projectProvider.listProject.last ? 45 : 0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${data.name}', style: textStyle.labelSmall),
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
                    );
                  },
                )
              : const Center(child: Text('Data Tidak Ditemukan')),
        );
      },
    );
  }
}
