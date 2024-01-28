import 'package:flutter/material.dart';
import 'package:responsible_development/common/colors.dart';
import 'package:responsible_development/common/styles.dart';
import 'package:responsible_development/ui/history/history_view.dart';
import 'package:responsible_development/ui/home/home_view.dart';
import 'package:responsible_development/ui/profile/profile_view.dart';
import 'package:responsible_development/ui/project/project_view.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });
  final int selectedIndex;
  final Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 55,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ItemNavbar(
            isSelected: selectedIndex == 0,
            label: HomeView.title,
            icon: Icons.home_rounded,
            onTap: () => onTap(0),
          ),
          ItemNavbar(
            isSelected: selectedIndex == 1,
            label: HistoryView.title,
            icon: Icons.pending_actions_rounded,
            onTap: () => onTap(1),
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 5),
          ItemNavbar(
            isSelected: selectedIndex == 2,
            label: ProjectView.title,
            icon: Icons.list_alt_rounded,
            onTap: () => onTap(2),
          ),
          ItemNavbar(
            isSelected: selectedIndex == 3,
            label: ProfileView.title,
            icon: Icons.person_rounded,
            onTap: () => onTap(3),
          ),
        ],
      ),
    );
  }
}

class ItemNavbar extends StatelessWidget {
  const ItemNavbar({
    super.key,
    required this.isSelected,
    required this.label,
    this.assetIcon = '',
    this.onTap,
    this.icon,
  });

  final bool isSelected;
  final String label;
  final String assetIcon;
  final Function()? onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isSelected ? 24 : 20,
              height: isSelected ? 24 : 20,
              child: assetIcon.isNotEmpty
                  ? Image.asset(
                      assetIcon,
                      color: isSelected ? AppColor.primary : Colors.grey,
                    )
                  : Icon(
                      icon,
                      color: isSelected ? AppColor.primary : Colors.grey,
                      size: isSelected ? 24 : 20,
                    ),
            ),
            Text(
              label,
              style: textStyle.bodySmall!.copyWith(
                color: isSelected ? AppColor.primary : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
