import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsible_development/common/styles.dart';
import 'package:responsible_development/provider/history_provider.dart';
import 'package:responsible_development/services/navigation_service.dart';
import 'package:responsible_development/ui/history/history_detail_view.dart';
import 'package:responsible_development/utils/app_utils.dart';
import 'package:responsible_development/widgets/buttons/button_primary.dart';
import 'package:responsible_development/widgets/cards/card_custom.dart';
import 'package:responsible_development/widgets/others/custom_divider.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  static String routeName = '/history';
  static String title = 'Riwayat';

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  void initState() {
    context.read<HistoryProvider>().getHistory(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryProvider>(
      builder: (context, historyProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Riwayat Aktivitas'),
            centerTitle: true,
          ),
          body: historyProvider.listMyHistory.isNotEmpty
              ? Stack(
                  children: [
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: historyProvider.listMyHistory.length,
                      itemBuilder: (context, index) {
                        final data = historyProvider.listMyHistory[index];
                        return InkWell(
                          onTap: () {
                            NavigationService.pushNamed(
                              HistoryDetailView.routeName,
                              arguments: data,
                            );
                          },
                          child: CardCustom(
                            backgroundColor: data.isSynchronize == 0
                                ? Colors.yellow.shade700
                                : null,
                            padding: const EdgeInsets.all(12),
                            margin: EdgeInsets.fromLTRB(
                              12,
                              12,
                              12,
                              data == historyProvider.listMyHistory.last
                                  ? 45
                                  : 0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.projectName,
                                  style: textStyle.labelSmall!.copyWith(
                                    color: data.isSynchronize == 0
                                        ? Colors.white
                                        : null,
                                  ),
                                ),
                                const CustomDivider(),
                                Row(
                                  children: [
                                    Text(
                                      'Aktivitas ID : ',
                                      style: textStyle.bodyMedium!.copyWith(
                                        color: data.isSynchronize == 0
                                            ? Colors.white
                                            : null,
                                      ),
                                    ),
                                    Text(
                                      data.id,
                                      style: textStyle.bodyMedium!.copyWith(
                                        color: data.isSynchronize == 0
                                            ? Colors.white
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Tanggal : ',
                                      style: textStyle.bodyMedium!.copyWith(
                                        color: data.isSynchronize == 0
                                            ? Colors.white
                                            : null,
                                      ),
                                    ),
                                    Text(
                                      data.createdAt,
                                      style: textStyle.bodyMedium!.copyWith(
                                        color: data.isSynchronize == 0
                                            ? Colors.white
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Waktu Mulai : ',
                                      style: textStyle.bodyMedium!.copyWith(
                                        color: data.isSynchronize == 0
                                            ? Colors.white
                                            : null,
                                      ),
                                    ),
                                    Text(
                                      data.startTime,
                                      style: textStyle.bodyMedium!.copyWith(
                                        color: data.isSynchronize == 0
                                            ? Colors.white
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Waktu Selesai : ',
                                      style: textStyle.bodyMedium!.copyWith(
                                        color: data.isSynchronize == 0
                                            ? Colors.white
                                            : null,
                                      ),
                                    ),
                                    Text(
                                      data.finishTime,
                                      style: textStyle.bodyMedium!.copyWith(
                                        color: data.isSynchronize == 0
                                            ? Colors.white
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Durasi : ',
                                      style: textStyle.bodyMedium!.copyWith(
                                        color: data.isSynchronize == 0
                                            ? Colors.white
                                            : null,
                                      ),
                                    ),
                                    Text(
                                      AppUtils.getDuration(
                                        data.date,
                                        data.startTime,
                                        data.finishTime,
                                      ),
                                      style: textStyle.bodyMedium!.copyWith(
                                        color: data.isSynchronize == 0
                                            ? Colors.white
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                                if (data.isSynchronize == 0)
                                  Center(
                                    child: Text(
                                      'Need Upload',
                                      style: textStyle.labelSmall!.copyWith(
                                        color: data.isSynchronize == 0
                                            ? Colors.white
                                            : null,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 45, right: 16),
                        child: ButtonPrimary(
                          size: const Size(130, 40),
                          label: 'Upload Data',
                          onPressed: () {
                            historyProvider.uploadData(context);
                          },
                        ),
                      ),
                    ),
                  ],
                )
              : const Center(child: Text('Data Tidak Ditemukan')),
        );
      },
    );
  }
}
