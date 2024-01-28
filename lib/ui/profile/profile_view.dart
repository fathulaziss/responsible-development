import 'package:flutter/material.dart';
import 'package:responsible_development/common/styles.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  static String routeName = '/profile';
  static String title = 'Profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Profile View', style: textStyle.bodyMedium)),
    );
  }
}
