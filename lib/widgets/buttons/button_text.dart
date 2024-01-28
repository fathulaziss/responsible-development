import 'package:flutter/material.dart';
import 'package:responsible_development/common/styles.dart';

class ButtonText extends StatelessWidget {
  const ButtonText({
    super.key,
    required this.label,
    required this.onTap,
    this.labelStyle,
    this.padding,
  });
  final String label;
  final TextStyle? labelStyle;
  final EdgeInsets? padding;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(4),
        child: Text(label, style: labelStyle ?? textStyle.labelSmall),
      ),
    );
  }
}
