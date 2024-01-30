import 'dart:io';

import 'package:flutter/material.dart';
import 'package:responsible_development/app.dart';
import 'package:responsible_development/common/enum.dart';
import 'package:responsible_development/services/api_service.dart';
import 'package:responsible_development/utils/app_config.dart';

Future<void> setupApp({
  bool isProduction = false,
  bool isDevelopment = false,
  bool isStaging = false,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig.appFlavor = isProduction ? Flavor.production : Flavor.development;
  HttpOverrides.global = MyHttpOverrides();
  // await initFirebase();
  start();
}

// Future<void> initFirebase() async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await FirebaseService().initializeFirebaseMessaging();
//   // await FirebaseService().initializeFirebaseMessagingHandler();
// }
