import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:responsible_development/common/styles.dart';
import 'package:responsible_development/models/project_model.dart';
import 'package:responsible_development/provider/auth_provider.dart';
import 'package:responsible_development/provider/my_project_provider.dart';
import 'package:responsible_development/provider/profile_provider.dart';
import 'package:responsible_development/provider/project_provider.dart';
import 'package:responsible_development/provider/sync_provider.dart';
import 'package:responsible_development/provider/utility_provider.dart';
import 'package:responsible_development/services/navigation_service.dart';
import 'package:responsible_development/ui/activity/activity_view.dart';
import 'package:responsible_development/ui/login/login_view.dart';
import 'package:responsible_development/ui/main/main_view.dart';
import 'package:responsible_development/ui/my_project/my_project_add_view.dart';
import 'package:responsible_development/ui/my_project/my_project_view.dart';
import 'package:responsible_development/ui/project/project_detail_view.dart';
import 'package:responsible_development/ui/splash/splash_view.dart';
import 'package:responsible_development/ui/sync/sync_view.dart';
import 'package:responsible_development/utils/app_utils.dart';
import 'package:responsible_development/widgets/others/loading_indicator.dart';

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
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<ProfileProvider>(
          create: (context) => ProfileProvider(),
        ),
        ChangeNotifierProvider<SyncProvider>(
          create: (context) => SyncProvider(),
        ),
        ChangeNotifierProvider<ProjectProvider>(
          create: (context) => ProjectProvider(),
        ),
        ChangeNotifierProvider<MyProjectProvider>(
          create: (context) => MyProjectProvider(),
        ),
      ],
      child: Consumer<UtilityProvider>(
        builder: (context, utilityProvider, _) {
          return GlobalLoaderOverlay(
            useDefaultLoading: false,
            overlayWidgetBuilder: (progress) => const LoadingIndicator(),
            overlayColor: Colors.black.withOpacity(.65),
            child: MaterialApp(
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
                SyncView.routeName: (context) => const SyncView(),
                MainView.routeName: (context) => const MainView(),
                ProjectDetailView.routeName: (context) {
                  final data =
                      ModalRoute.of(context)!.settings.arguments != null
                          ? ModalRoute.of(context)!.settings.arguments!
                              as ProjectModel
                          : ProjectModel();
                  return ProjectDetailView(data: data);
                },
                ActivityView.routeName: (context) => const ActivityView(),
                MyProjectView.routeName: (context) => const MyProjectView(),
                MyProjectAddView.routeName: (context) =>
                    const MyProjectAddView(),
              },
            ),
          );
        },
      ),
    );
  }
}
