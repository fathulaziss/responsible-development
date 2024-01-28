import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsible_development/common/styles.dart';
import 'package:responsible_development/provider/utility_provider.dart';
import 'package:responsible_development/widgets/buttons/button_primary.dart';

class ButtonSecondary extends StatelessWidget {
  const ButtonSecondary({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.padding,
    this.size,
  });

  final String label;
  final Function() onPressed;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    return Consumer<UtilityProvider>(
      builder: (context, utilityProvider, _) {
        return ButtonPrimary(
          label: label,
          labelStyle: backgroundColor == null
              ? textStyle.bodyMedium
              : textStyle.bodyMedium!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          radius: 4,
          size: size ?? const Size(20, 30),
          backgroundColor: backgroundColor == null
              ? utilityProvider.isDarkTheme ||
                      MediaQuery.of(context).platformBrightness ==
                          Brightness.dark
                  ? Colors.grey.shade700
                  : Colors.white
              : backgroundColor!,
          overlayColor: backgroundColor == null
              ? utilityProvider.isDarkTheme ||
                      MediaQuery.of(context).platformBrightness ==
                          Brightness.dark
                  ? Colors.grey.shade800
                  : Colors.grey.shade300
              : null,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 8),
          onPressed: onPressed,
        );
      },
    );
  }
}
