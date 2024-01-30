import 'package:flutter/material.dart';
import 'package:responsible_development/common/styles.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static String routeName = '/home';
  static String title = 'Beranda';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Home View', style: textStyle.bodyMedium)),
    );
  }
}
