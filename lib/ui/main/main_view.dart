import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsible_development/common/colors.dart';
import 'package:responsible_development/provider/utility_provider.dart';
import 'package:responsible_development/ui/history/history_view.dart';
import 'package:responsible_development/ui/home/home_view.dart';
import 'package:responsible_development/ui/profile/profile_view.dart';
import 'package:responsible_development/ui/project/project_view.dart';
import 'package:responsible_development/widgets/others/custom_bottom_navbar.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  static String routeName = '/main';

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  PageController pageController = PageController();

  int _menuIndex = 0;

  final _menus = [
    const HomeView(),
    const HistoryView(),
    const ProjectView(),
    const ProfileView(),
  ];

  void _onChangeMenu(int index) {
    _menuIndex = index;
    pageController.jumpToPage(index);
    setState(() {});
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UtilityProvider>(
      builder: (context, utilityProvider, _) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            backgroundColor: AppColor.primary,
            onPressed: () {},
            child: const Icon(Icons.assignment_add, color: Colors.white),
          ),
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            color: utilityProvider.isDarkTheme ||
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Colors.black
                : Colors.white,
            surfaceTintColor: Colors.white,
            shadowColor: Colors.grey.shade300,
            height: 60,
            elevation: 10,
            notchMargin: 10,
            padding: EdgeInsets.zero,
            child: CustomBottomNavBar(
              selectedIndex: _menuIndex,
              onTap: _onChangeMenu,
            ),
          ),
          body: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: _menus,
          ),
        );
      },
    );
  }
}
