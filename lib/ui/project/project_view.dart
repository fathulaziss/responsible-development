import 'package:flutter/material.dart';
import 'package:responsible_development/common/styles.dart';

class ProjectView extends StatelessWidget {
  const ProjectView({super.key});

  static String routeName = '/project';
  static String title = 'Project';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Project View', style: textStyle.bodyMedium)),
    );
  }
}
