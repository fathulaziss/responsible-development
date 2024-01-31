import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsible_development/common/colors.dart';
import 'package:responsible_development/common/styles.dart';
import 'package:responsible_development/provider/auth_provider.dart';
import 'package:responsible_development/provider/profile_provider.dart';
import 'package:responsible_development/provider/utility_provider.dart';
import 'package:responsible_development/services/navigation_service.dart';
import 'package:responsible_development/ui/my_project/my_project_view.dart';
import 'package:responsible_development/utils/app_config.dart';
import 'package:responsible_development/widgets/others/custom_divider.dart';
import 'package:responsible_development/widgets/others/custom_item_row.dart';
import 'package:responsible_development/widgets/others/show_dialog.dart';
import 'package:responsible_development/widgets/others/vertical_space.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  static String routeName = '/profile';
  static String title = 'Profil';

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    context.read<ProfileProvider>().getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UtilityProvider>(
      builder: (context, utilityProvider, _) {
        return Consumer<ProfileProvider>(
          builder: (context, profileProvider, _) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Profil', textAlign: TextAlign.center),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.primary, width: 2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.account_circle,
                      size: 75,
                      color: AppColor.primary,
                    ),
                  ),
                  Text(
                    '${profileProvider.user.name}',
                    style: textStyle.labelSmall,
                  ),
                  Text(
                    '${profileProvider.user.email}',
                    style: textStyle.bodyMedium,
                  ),
                  Text(
                    '${profileProvider.user.username}',
                    style: textStyle.bodyMedium,
                  ),
                  const VerticalSpace(height: 16),
                  const CustomDivider(height: 0),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          CustomItemRow(
                            labelText: 'Mode Gelap',
                            value: Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Switch(
                                value: utilityProvider.isDarkTheme,
                                onChanged: (value) {
                                  utilityProvider.setDarkTheme(value: value);
                                },
                                inactiveTrackColor: Colors.grey.shade400,
                                activeColor: AppColor.primary,
                              ),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          CustomItemRow(
                            labelText: 'Proyek RD Saya',
                            onTap: () {
                              NavigationService.pushNamed(
                                MyProjectView.routeName,
                              );
                            },
                          ),
                          CustomItemRow(
                            labelText: 'Log Out',
                            value: const Icon(Icons.exit_to_app),
                            onTap: () {
                              showDialogOption(
                                context,
                                title: 'Log Out',
                                desc: 'Apakah Anda yakin ingin keluar ?',
                                onTapPositif: () {
                                  context.read<AuthProvider>().logout(context);
                                },
                              );
                            },
                          ),
                          CustomItemRow(
                            labelText: 'Versi App',
                            valueText:
                                '${utilityProvider.appVersion} ${AppConfig.environmentType}',
                            isValueText: true,
                            isShowDivider: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
