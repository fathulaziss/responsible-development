import 'package:flutter/material.dart';
import 'package:responsible_development/common/styles.dart';

class CustomTable extends StatelessWidget {
  const CustomTable({
    super.key,
    required this.labelLeft,
    required this.labelRight,
    required this.decorationLeft,
    required this.decorationRight,
  });

  final String labelLeft;
  final String labelRight;
  final Decoration decorationLeft;
  final Decoration decorationRight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 45,
            decoration: decorationLeft,
            child: Center(
              child: Text(labelLeft, style: textStyle.labelSmall),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 45,
            decoration: decorationRight,
            child: Center(
              child: Text(labelRight, style: textStyle.labelSmall),
            ),
          ),
        ),
      ],
    );
  }
}
