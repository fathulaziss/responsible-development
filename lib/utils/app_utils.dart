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

  static String convertDateTimeToString(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy HH:mm:ss').format(dateTime);
  }

  static DateTime convertStringToDateTime(String dateTime) {
    return DateFormat('dd-MM-yyyy HH:mm:ss').parse(dateTime);
  }

  static String convertTimeOfDayToString(TimeOfDay? timeOfDay) {
    return '${timeOfDay?.hour.toString().padLeft(2, '0')}:${timeOfDay?.minute.toString().padLeft(2, '0')}';
  }

  static TimeOfDay convertStringToTimeOfDay(String timeOfDay) {
    return TimeOfDay(
      hour: int.parse(timeOfDay.split(':')[0]),
      minute: int.parse(timeOfDay.split(':')[1]),
    );
  }

  static String getDuration(
    String dateTime,
    String timeStart,
    String timeFinish,
  ) {
    final date = dateTime.split(' ');
    final dateTimeStart =
        DateFormat('dd-MM-yyyy HH:mm').parse('${date[0]} $timeStart');
    final dateTimeFinish =
        DateFormat('dd-MM-yyyy HH:mm').parse('${date[0]} $timeFinish');
    final duration = dateTimeFinish.difference(dateTimeStart);
    final durationConvert = duration.toString().split(':');
    return '${durationConvert[0]}j ${durationConvert[1].padLeft(2, '0')}m';
  }

  static int getDurationInt(
    String dateTime,
    String timeStart,
    String timeFinish,
  ) {
    final date = dateTime.split(' ');
    final dateTimeStart =
        DateFormat('dd-MM-yyyy HH:mm').parse('${date[0]} $timeStart');
    final dateTimeFinish =
        DateFormat('dd-MM-yyyy HH:mm').parse('${date[0]} $timeFinish');
    final duration = dateTimeFinish.difference(dateTimeStart).inMinutes;
    return duration;
  }

  static String getMonth(int month) {
    switch (month) {
      case 1:
        return 'Januari';
      case 2:
        return 'Februari';
      case 3:
        return 'Maret';
      case 4:
        return 'April';
      case 5:
        return 'Mei';
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'Agustus';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      case 12:
        return 'Desember';
      default:
        return 'Desember';
    }
  }
}
