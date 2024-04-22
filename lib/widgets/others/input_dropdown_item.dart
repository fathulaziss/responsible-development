import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsible_development/common/styles.dart';
import 'package:responsible_development/provider/utility_provider.dart';

class InputDropdownItem extends StatelessWidget {
  const InputDropdownItem({super.key, required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Consumer<UtilityProvider>(
      builder: (context, utilityProvider, _) {
        return Flex(
          crossAxisAlignment: CrossAxisAlignment.start,
          direction: Axis.vertical,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(value, style: textStyle.bodyMedium),
              ),
            ),
            Divider(
              color: (utilityProvider.isDarkTheme ||
                      MediaQuery.of(context).platformBrightness ==
                          Brightness.dark)
                  ? Colors.white
                  : Colors.grey.shade300,
            ),
          ],
        );
      },
    );
  }
}
