import 'package:flutter/material.dart';
import 'package:responsible_development/common/styles.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  static String routeName = '/history';
  static String title = 'Riwayat';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('History View', style: textStyle.bodyMedium)),
    );
  }
}
