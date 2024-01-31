import 'package:flutter/material.dart';
import 'package:responsible_development/common/colors.dart';

class InputSearchDropdonwItem extends StatelessWidget {
  const InputSearchDropdonwItem({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColor.scaffoldBackground)),
      ),
      child: child,
    );
  }
}
