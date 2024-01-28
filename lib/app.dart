import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:responsible_development/common/styles.dart';
import 'package:responsible_development/provider/utility_provider.dart';
import 'package:responsible_development/services/navigation_service.dart';
import 'package:responsible_development/ui/login/login_view.dart';
import 'package:responsible_development/ui/main/main_view.dart';
import 'package:responsible_development/ui/splash/splash_view.dart';
import 'package:responsible_development/utils/app_utils.dart';

void start() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UtilityProvider>(
          create: (context) => UtilityProvider(),
        ),
      ],
      child: Consumer<UtilityProvider>(
        builder: (context, utilityProvider, _) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            theme: utilityProvider.theme,
            darkTheme: darkTheme,
            locale: Locale(
              utilityProvider.appLanguage.languageCode,
              utilityProvider.appLanguage.countryCode,
            ),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('id', 'ID'),
            ],
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: const TextScaler.linear(1.22),
                ),
                child: GestureDetector(
                  onTap: AppUtils.dismissKeyboard,
                  child: child,
                ),
              );
            },
            initialRoute: SplashView.routeName,
            routes: {
              SplashView.routeName: (context) => const SplashView(),
              LoginView.routeName: (context) => const LoginView(),
              MainView.routeName: (context) => const MainView(),
            },
          );
        },
      ),
    );
  }
}
