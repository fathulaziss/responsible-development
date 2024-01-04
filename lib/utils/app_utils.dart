import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppUtils {
  static void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static void logger(String value) {
    if (kDebugMode) {
      log(value);
    }
  }
}
