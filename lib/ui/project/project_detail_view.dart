import 'package:flutter/material.dart';
import 'package:responsible_development/common/styles.dart';
import 'package:responsible_development/models/project_model.dart';
import 'package:responsible_development/widgets/others/custom_divider.dart';

class ProjectDetailView extends StatelessWidget {
  const ProjectDetailView({super.key, this.data});

  final ProjectModel? data;
  static String routeName = '/project-detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rincian Proyek'),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Text('Nama Proyek', style: textStyle.labelSmall),
                ),
                Text(': ', style: textStyle.labelSmall),
                Expanded(
                  flex: 5,
                  child: Text(
                    data!.name!.isNotEmpty ? data!.name! : '-',
                    style: textStyle.labelSmall,
                  ),
                ),
              ],
            ),
            const CustomDivider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Text('Kategori', style: textStyle.labelSmall),
                ),
                Text(': ', style: textStyle.labelSmall),
                Expanded(
                  flex: 5,
                  child: Text(
                    data!.category!.isNotEmpty ? data!.category! : '-',
                    style: textStyle.labelSmall,
                  ),
                ),
              ],
            ),
            const CustomDivider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Text('Lokasi', style: textStyle.labelSmall),
                ),
                Text(': ', style: textStyle.labelSmall),
                Expanded(
                  flex: 5,
                  child: Text(
                    data!.location!.isNotEmpty
                        ? data!.location!.join(', ')
                        : '-',
                    style: textStyle.labelSmall,
                  ),
                ),
              ],
            ),
            const CustomDivider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Text('DIC', style: textStyle.labelSmall),
                ),
                Text(': ', style: textStyle.labelSmall),
                Expanded(
                  flex: 5,
                  child: Text(
                    data!.dic!.isNotEmpty ? data!.dic!.join(', ') : '-',
                    style: textStyle.labelSmall,
                  ),
                ),
              ],
            ),
            const CustomDivider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Text('PIC', style: textStyle.labelSmall),
                ),
                Text(': ', style: textStyle.labelSmall),
                Expanded(
                  flex: 5,
                  child: Text(
                    data!.pic!.isNotEmpty ? data!.pic!.join(', ') : '-',
                    style: textStyle.labelSmall,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
