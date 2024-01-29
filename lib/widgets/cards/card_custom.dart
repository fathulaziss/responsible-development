import 'package:flutter/material.dart';

class CardCustom extends StatelessWidget {
  const CardCustom({
    super.key,
    this.backgroundColor,
    required this.child,
    this.elevation = 1,
    this.margin,
    this.padding,
    this.radius,
  });

  final Color? backgroundColor;
  final Widget child;
  final double elevation;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      elevation: elevation,
      surfaceTintColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 8),
      ),
      margin: margin,
      child: Padding(padding: padding ?? EdgeInsets.zero, child: child),
    );
  }
}
