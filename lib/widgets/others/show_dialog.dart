import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsible_development/common/styles.dart';
import 'package:responsible_development/provider/utility_provider.dart';
import 'package:responsible_development/services/navigation_service.dart';
import 'package:responsible_development/widgets/buttons/button_primary.dart';
import 'package:responsible_development/widgets/buttons/button_text.dart';
import 'package:toast/toast.dart';

void showToast(
  BuildContext context, {
  required String message,
  Color? backgroundColor,
  Color? textColor,
  int? gravity,
  int? duration,
}) {
  ToastContext().init(context);
  Toast.show(
    message,
    textStyle: textStyle.labelSmall!
        .copyWith(color: textColor ?? Colors.white, fontSize: 10),
    backgroundColor: backgroundColor ?? const Color(0xAA000000),
    gravity: gravity ?? 0,
    duration: duration ?? 2,
  );
}

void showDialogCustom(
  BuildContext context, {
  String? title,
  TextStyle? titleStyle,
  TextAlign? titleAlign,
  required Widget content,
  List<Widget>? actions,
  EdgeInsets? titlePadding,
  EdgeInsets? actionPadding,
  EdgeInsets? contentPadding,
  MainAxisAlignment? actionsAlignment,
  bool? barrierDismissible,
}) {
  showDialog(
    context: context,
    barrierDismissible: barrierDismissible ?? false,
    builder: (BuildContext context) {
      return Consumer<UtilityProvider>(
        builder: (context, utilityProvider, _) {
          return AlertDialog(
            backgroundColor: utilityProvider.isDarkTheme ||
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Colors.grey.shade800
                : Colors.white,
            surfaceTintColor: utilityProvider.isDarkTheme ||
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Colors.grey.shade800
                : Colors.white,
            titlePadding:
                titlePadding ?? const EdgeInsets.fromLTRB(24, 16, 24, 12),
            contentPadding:
                contentPadding ?? const EdgeInsets.symmetric(horizontal: 24),
            actionsPadding:
                actionPadding ?? const EdgeInsets.fromLTRB(24, 12, 24, 16),
            insetPadding: const EdgeInsets.all(32),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            titleTextStyle: titleStyle ??
                textStyle.titleSmall!.copyWith(
                  color: utilityProvider.isDarkTheme ||
                          MediaQuery.of(context).platformBrightness ==
                              Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
            title: Text(title ?? '', textAlign: titleAlign ?? TextAlign.left),
            content: content,
            actionsAlignment: actionsAlignment,
            actions: actions,
          );
        },
      );
    },
  );
}

void showDialogOption(
  BuildContext context, {
  required String title,
  required String desc,
  required Function() onTapPositif,
  String labelButtonPositif = 'Ya',
  String labelButtonNegatif = 'Tidak',
}) {
  showDialogCustom(
    context,
    title: title,
    content: Consumer<UtilityProvider>(
      builder: (context, utilityProvider, _) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Text(
            desc,
            style: textStyle.bodyMedium!.copyWith(
              color: utilityProvider.isDarkTheme ||
                      MediaQuery.of(context).platformBrightness ==
                          Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        );
      },
    ),
    actions: [
      ButtonPrimary(
        label: labelButtonNegatif,
        size: const Size(50, 30),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        labelStyle: textStyle.labelSmall!.copyWith(color: Colors.white),
        backgroundColor: Colors.red,
        overlayColor: Colors.redAccent,
        onPressed: NavigationService.pop,
      ),
      ButtonPrimary(
        label: labelButtonPositif,
        size: const Size(50, 30),
        labelStyle: textStyle.labelSmall!.copyWith(color: Colors.white),
        backgroundColor: Colors.blue,
        overlayColor: Colors.blueAccent,
        onPressed: () {
          NavigationService.pop();
          onTapPositif();
        },
      ),
    ],
  );
}

void showDialogError(
  BuildContext context, {
  required String title,
  required String desc,
  Function()? onTap,
}) {
  showDialogCustom(
    context,
    title: title,
    content: Consumer<UtilityProvider>(
      builder: (context, utilityProvider, _) {
        return Text(
          desc,
          style: textStyle.bodyMedium!.copyWith(
            color: utilityProvider.isDarkTheme ||
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        );
      },
    ),
    actions: [
      ButtonText(
        label: 'OK',
        labelStyle: textStyle.labelSmall!.copyWith(color: Colors.blue),
        onTap: () {
          if (onTap == null) {
            NavigationService.pop();
          } else {
            onTap();
            NavigationService.pop();
          }
        },
      ),
    ],
  );
}

void showDialogInfo(
  BuildContext context, {
  required String title,
  required String desc,
  String? labelButton,
  Function()? onTap,
}) {
  showDialogCustom(
    context,
    title: title,
    content: Consumer<UtilityProvider>(
      builder: (context, utilityProvider, _) {
        return Text(
          desc,
          style: textStyle.bodyMedium!.copyWith(
            color: utilityProvider.isDarkTheme ||
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        );
      },
    ),
    actions: [
      ButtonText(
        label: labelButton ?? 'OK',
        labelStyle: textStyle.labelSmall!.copyWith(color: Colors.blue),
        onTap: () {
          if (onTap == null) {
            NavigationService.pop();
          } else {
            onTap();
            NavigationService.pop();
          }
        },
      ),
    ],
  );
}

void closeDialogLoading(BuildContext context) {
  NavigationService.pop();
}
