import 'package:flutter/material.dart';
import 'package:responsible_development/common/colors.dart';

TextStyle textBaseLight =
    const TextStyle(fontFamily: 'DIN Pro Light', fontWeight: FontWeight.normal);
TextStyle textBaseMedium =
    const TextStyle(fontFamily: 'DIN Pro Medium', fontWeight: FontWeight.bold);

final textStyle = TextTheme(
  titleLarge: textBaseMedium.copyWith(fontSize: 18),
  titleMedium: textBaseMedium.copyWith(fontSize: 16),
  titleSmall: textBaseMedium.copyWith(fontSize: 14),
  labelLarge: textBaseMedium.copyWith(fontSize: 16),
  labelMedium: textBaseMedium.copyWith(fontSize: 14),
  labelSmall: textBaseMedium.copyWith(fontSize: 12),
  bodyLarge: textBaseLight.copyWith(fontSize: 14),
  bodyMedium: textBaseLight.copyWith(fontSize: 12),
  bodySmall: textBaseLight.copyWith(fontSize: 10),
);

final darkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    surfaceTintColor: AppColor.backgroundDark,
    titleTextStyle: textStyle.titleSmall!.copyWith(color: Colors.white),
  ),
  brightness: Brightness.dark,
  colorScheme: ThemeData.dark().colorScheme.copyWith(
        primary: Colors.white,
        onPrimary: Colors.black,
        secondary: AppColor.primaryDark,
      ),
  cardTheme: CardTheme(surfaceTintColor: AppColor.backgroundDark),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(AppColor.primary),
      surfaceTintColor: MaterialStateProperty.all(AppColor.primary),
      overlayColor:
          MaterialStateProperty.all(Colors.grey.shade300.withOpacity(0.5)),
    ),
  ),
  fontFamily: 'DIN Pro',
  indicatorColor: AppColor.indicator,
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(AppColor.primary),
    ),
  ),
  scaffoldBackgroundColor: Colors.black,
  textTheme: textStyle,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
      backgroundColor:
          MaterialStateColor.resolveWith((states) => Colors.orange),
      overlayColor:
          MaterialStateColor.resolveWith((states) => Colors.deepOrange),
    ),
  ),
  timePickerTheme: timePickerTheme,
  datePickerTheme: datePickerTheme,
  useMaterial3: true,
);

final lightTheme = ThemeData(
  appBarTheme: AppBarTheme(
    color: AppColor.primary,
    titleTextStyle: textStyle.titleSmall!.copyWith(color: Colors.white),
  ),
  brightness: Brightness.light,
  colorScheme: ThemeData.light().colorScheme.copyWith(
        primary: Colors.black,
        onPrimary: Colors.white,
        secondary: AppColor.primaryLight,
      ),
  cardColor: Colors.white,
  cardTheme:
      const CardTheme(color: Colors.white, surfaceTintColor: Colors.white),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(AppColor.primary),
      surfaceTintColor: MaterialStateProperty.all(AppColor.primary),
      overlayColor: MaterialStateProperty.all(AppColor.primaryLight),
    ),
  ),
  fontFamily: 'DIN Pro',
  indicatorColor: AppColor.indicator,
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(AppColor.primary),
    ),
  ),
  scaffoldBackgroundColor: AppColor.scaffoldBackground,
  textTheme: textStyle,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
      backgroundColor:
          MaterialStateColor.resolveWith((states) => Colors.orange),
      overlayColor:
          MaterialStateColor.resolveWith((states) => Colors.deepOrange),
    ),
  ),
  timePickerTheme: timePickerTheme,
  datePickerTheme: datePickerTheme,
  useMaterial3: true,
);

InputDecoration inputDecoration({
  required String hintText,
  Widget? prefixIcon,
  Widget? suffixIcon,
  TextStyle? hintStyle,
  EdgeInsets? padding,
  Color? hintColor,
}) {
  return InputDecoration(
    isDense: true,
    // filled: true,
    contentPadding:
        padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    hintText: hintText,
    border: InputBorder.none,
    errorMaxLines: 5,
    prefixIcon: prefixIcon,
    prefixIconConstraints: const BoxConstraints(minHeight: 30, minWidth: 30),
    suffixIconConstraints: const BoxConstraints(minHeight: 30, minWidth: 30),
    suffixIcon: suffixIcon,
    hintStyle: hintStyle ??
        textStyle.bodyMedium!
            .copyWith(color: hintColor ?? const Color(0xFFC1BABA)),
  );
}

final timePickerTheme = TimePickerThemeData(
  backgroundColor: Colors.blueGrey,
  hourMinuteShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: Colors.orange, width: 4),
  ),
  dayPeriodBorderSide: BorderSide(color: Colors.blueGrey.shade800, width: 4),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: Colors.orange, width: 4),
  ),
  dayPeriodTextColor: Colors.white,
  dayPeriodShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: Colors.orange, width: 4),
  ),
  hourMinuteColor: MaterialStateColor.resolveWith(
    (states) => states.contains(MaterialState.selected)
        ? Colors.orange
        : Colors.blueGrey.shade800,
  ),
  hourMinuteTextColor: MaterialStateColor.resolveWith(
    (states) =>
        states.contains(MaterialState.selected) ? Colors.white : Colors.orange,
  ),
  dialHandColor: Colors.blueGrey.shade700,
  dialBackgroundColor: Colors.blueGrey.shade800,
  hourMinuteTextStyle: textStyle.titleMedium!.copyWith(fontSize: 20),
  helpTextStyle: textStyle.labelSmall!.copyWith(color: Colors.white),
  inputDecorationTheme: const InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.orange, width: 4),
    ),
    contentPadding: EdgeInsets.zero,
  ),
  dialTextStyle: textStyle.labelMedium!.copyWith(color: Colors.white),
  cancelButtonStyle: ButtonStyle(
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    backgroundColor: MaterialStateProperty.all(Colors.red),
    overlayColor: MaterialStateProperty.all(Colors.red),
    textStyle: MaterialStateProperty.all(
      textStyle.labelMedium!.copyWith(color: Colors.white),
    ),
  ),
  confirmButtonStyle: ButtonStyle(
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    backgroundColor: MaterialStateProperty.all(Colors.green),
    overlayColor: MaterialStateProperty.all(Colors.green),
    textStyle: MaterialStateProperty.all(
      textStyle.labelMedium!.copyWith(color: Colors.white),
    ),
  ),
  dialTextColor: MaterialStateColor.resolveWith(
    (states) =>
        states.contains(MaterialState.selected) ? Colors.orange : Colors.white,
  ),
  entryModeIconColor: Colors.orange,
);

final datePickerTheme = DatePickerThemeData(
  cancelButtonStyle: ButtonStyle(
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    backgroundColor: MaterialStateProperty.all(Colors.red),
    overlayColor: MaterialStateProperty.all(Colors.red),
    textStyle: MaterialStateProperty.all(
      textStyle.labelMedium!.copyWith(color: Colors.white),
    ),
  ),
  confirmButtonStyle: ButtonStyle(
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    backgroundColor: MaterialStateProperty.all(Colors.green),
    overlayColor: MaterialStateProperty.all(Colors.green),
    textStyle: MaterialStateProperty.all(
      textStyle.labelMedium!.copyWith(color: Colors.white),
    ),
  ),
);
