import 'package:flutter/material.dart';
import 'package:responsible_development/common/styles.dart';
import 'package:responsible_development/widgets/others/custom_divider.dart';
import 'package:responsible_development/widgets/others/horizontal_space.dart';

class CustomItemRow extends StatelessWidget {
  const CustomItemRow({
    super.key,
    this.additional,
    this.onTap,
    this.label,
    this.labelText = '',
    this.labelTextStyle,
    this.value,
    this.valueText = '',
    this.valueTextStyle,
    this.padding,
    this.alignment = Alignment.centerRight,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.isValueText = false,
    this.isLabelText = true,
    this.isShowDivider = true,
  });

  final Widget? additional;
  final Function()? onTap;
  final Widget? label;
  final String labelText;
  final TextStyle? labelTextStyle;
  final Widget? value;
  final String valueText;
  final TextStyle? valueTextStyle;
  final EdgeInsets? padding;
  final AlignmentGeometry alignment;
  final CrossAxisAlignment crossAxisAlignment;
  final bool isValueText;
  final bool isLabelText;
  final bool isShowDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: padding ?? const EdgeInsets.symmetric(vertical: 12),
            child: isLabelText
                ? Row(
                    crossAxisAlignment: crossAxisAlignment,
                    children: [
                      Text(
                        labelText,
                        style: labelTextStyle ?? textStyle.labelSmall,
                      ),
                      Expanded(
                        child: Align(
                          alignment: alignment,
                          child: isValueText
                              ? Text(
                                  valueText,
                                  style: valueTextStyle ?? textStyle.bodyMedium,
                                  textAlign: TextAlign.end,
                                )
                              : value,
                        ),
                      ),
                    ],
                  )
                : Row(
                    crossAxisAlignment: crossAxisAlignment,
                    children: [
                      label ?? const SizedBox(),
                      const HorizontalSpace(width: 8),
                      Expanded(
                        child: Align(
                          alignment: alignment,
                          child: isValueText
                              ? Text(
                                  valueText,
                                  style: valueTextStyle ?? textStyle.bodyMedium,
                                  textAlign: TextAlign.end,
                                )
                              : value,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        if (additional != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: additional,
          ),
        if (isShowDivider) const CustomDivider(height: 0),
      ],
    );
  }
}
