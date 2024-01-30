import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsible_development/provider/utility_provider.dart';
import 'package:responsible_development/services/app_cycle_service.dart';
import 'package:responsible_development/utils/app_asset.dart';
import 'package:responsible_development/widgets/others/footer_default.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  static String routeName = '/splash';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    AppCycleService().checkTokenAndRoute();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UtilityProvider>(
      builder: (context, utilityProvider, _) {
        return Scaffold(
          backgroundColor: utilityProvider.isDarkTheme ||
                  MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Colors.black
              : Colors.white,
          bottomNavigationBar: const FooterDefault(),
          body: Center(
            child: Image.asset(AppAsset.logo('logo-anj.png'), height: 65),
          ),
        );
      },
    );
  }
}
