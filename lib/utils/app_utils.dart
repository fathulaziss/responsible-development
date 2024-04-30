import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppUtils {
  static void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static void logger(String value) {
    if (kDebugMode) {
      log(value);
    }
  }

  static String generateActivityId() {
    final dateNow = DateTime.now();
    final dateNowConvert =
        '${dateNow.year.toString().substring(2)}${DateFormat('MM').format(dateNow)}${DateFormat('dd').format(dateNow)}${DateFormat('HH').format(dateNow)}${DateFormat('mm').format(dateNow)}${DateFormat('ss').format(dateNow)}';
    final random = math.Random();
    final randomNumber = random.nextInt(100);
    final activityId = 'ACT$dateNowConvert$randomNumber';
    return activityId;
  }

  static String convertDateTime(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy HH:mm:ss').format(dateTime);
  }
}
