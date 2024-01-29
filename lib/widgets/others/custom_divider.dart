import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsible_development/provider/utility_provider.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, this.height});

  final double? height;

  @override
  Widget build(BuildContext context) {
    return Consumer<UtilityProvider>(
      builder: (context, utilityProvider, _) {
        return Divider(
          color: utilityProvider.isDarkTheme ||
                  MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Colors.grey.shade700
              : Colors.grey.shade300,
          height: height,
        );
      },
    );
  }
}
