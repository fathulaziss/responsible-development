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
  });

  final String label;
  final TextStyle? labelStyle;
  final Size? size;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double? radius;
  final EdgeInsets? padding;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        surfaceTintColor: MaterialStateProperty.all(backgroundColor),
        overlayColor: MaterialStateProperty.all(overlayColor),
        minimumSize: MaterialStateProperty.all(
          size ?? Size(MediaQuery.of(context).size.width, 45),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 8),
          ),
        ),
        padding: MaterialStateProperty.all(padding),
      ),
      child: Text(
        label,
        style: labelStyle ??
            textStyle.titleSmall!
                .copyWith(color: Colors.white, fontWeight: FontWeight.w800),
      ),
    );
  }
}
