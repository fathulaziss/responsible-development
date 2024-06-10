import 'package:flutter/material.dart';
import 'package:responsible_development/common/styles.dart';

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary({
    super.key,
    required this.label,
    required this.onPressed,
    this.labelStyle,
    this.size,
    this.overlayColor,
    this.backgroundColor,
    this.radius,
    this.padding,
    this.child,
  });

  final String label;
  final TextStyle? labelStyle;
  final Size? size;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double? radius;
  final EdgeInsets? padding;
  final Function() onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(backgroundColor),
        surfaceTintColor: WidgetStateProperty.all(backgroundColor),
        overlayColor: WidgetStateProperty.all(overlayColor),
        minimumSize: WidgetStateProperty.all(
          size ?? Size(MediaQuery.of(context).size.width, 45),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 8),
          ),
        ),
        padding: WidgetStateProperty.all(padding),
      ),
      child: child ??
          Text(
            label,
            style: labelStyle ??
                textStyle.titleSmall!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w800),
          ),
    );
  }
}
