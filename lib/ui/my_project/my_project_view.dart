import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsible_development/provider/my_project_provider.dart';
import 'package:responsible_development/services/navigation_service.dart';
import 'package:responsible_development/ui/my_project/my_project_add_view.dart';
import 'package:responsible_development/widgets/buttons/button_primary.dart';

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
              : const SizedBox(),
        );
      },
    );
  }
}
