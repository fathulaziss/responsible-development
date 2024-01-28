import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsible_development/common/styles.dart';
import 'package:responsible_development/provider/utility_provider.dart';

class FooterDefault extends StatelessWidget {
  const FooterDefault({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UtilityProvider>(
      builder: (context, utilityProvider, _) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(utilityProvider.appVersion, style: textStyle.bodyMedium),
              Text('Powered By ANJ', style: textStyle.labelSmall),
            ],
          ),
        );
      },
    );
  }
}
