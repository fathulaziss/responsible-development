import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:responsible_development/common/colors.dart';
import 'package:responsible_development/common/enum.dart';
import 'package:responsible_development/common/styles.dart';
import 'package:responsible_development/provider/utility_provider.dart';

class InputSearchDropdown extends StatefulWidget {
  const InputSearchDropdown({
    super.key,
    this.autoFocus = false,
    this.controller,
    this.enabled = true,
    this.hintText = 'Type Here',
    this.inputFormatters,
    this.inputStyle = InputStyle.outline,
    required this.itemBuilder,
    this.keyboardType = TextInputType.text,
    this.labelText,
    this.labelStyle,
    this.labelTextColor,
    this.margin,
    this.maxLength = 1000,
    this.maxLines = 1,
    this.obsecureText = false,
    this.onChanged,
    this.preffixIcon,
    this.radius = 8,
    this.readOnly = false,
    this.suffixIcon,
    required this.suggestionsCallback,
    this.textAlign = TextAlign.left,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.onTapSuffixIcon,
    required this.onSelected,
  });

  final bool autoFocus;
  final TextEditingController? controller;
  final bool? enabled;
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final InputStyle inputStyle;
  final Widget Function(BuildContext, dynamic) itemBuilder;
  final TextInputType keyboardType;
  final String? labelText;
  final TextStyle? labelStyle;
  final Color? labelTextColor;
  final EdgeInsets? margin;
  final int maxLength;
  final int? maxLines;
  final bool obsecureText;
  final ValueSetter<String>? onChanged;
  final void Function(dynamic)? onSelected;
  final IconData? preffixIcon;
  final double radius;
  final bool readOnly;
  final IconData? suffixIcon;
  final FutureOr<List<dynamic>> Function(String) suggestionsCallback;
  final TextAlign textAlign;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final Function()? onTapSuffixIcon;

  @override
  State<InputSearchDropdown> createState() => _InputSearchDropdownState();
}

class _InputSearchDropdownState extends State<InputSearchDropdown> {
  TextFieldState tState = TextFieldState.none;
  List<TextInputFormatter> inputFormatters = [];
  bool isFocus = false;
  // String? Function(String?)? validator;

  @override
  void initState() {
    super.initState();
    if (widget.inputFormatters == null) {
      inputFormatters.add(LengthLimitingTextInputFormatter(widget.maxLength));
    } else {
      inputFormatters = widget.inputFormatters!;
      inputFormatters.add(LengthLimitingTextInputFormatter(widget.maxLength));
    }
  }

  void _onFocusChange(bool value) {
    setState(() {
      isFocus = value;
      if (value) {
        tState = TextFieldState.focus;
      } else {
        tState = TextFieldState.none;
      }
    });
  }

  InputBorder _disabledBorder() {
    if (widget.inputStyle == InputStyle.outline) {
      return OutlineInputBorder(
        borderSide: BorderSide(
          color: context.read<UtilityProvider>().isDarkTheme ||
                  MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Colors.grey.shade700
              : Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(widget.radius),
      );
    } else {
      return UnderlineInputBorder(
        borderSide: BorderSide(
          color: context.read<UtilityProvider>().isDarkTheme ||
                  MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Colors.grey.shade700
              : Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(widget.radius),
      );
    }
  }

  InputBorder _enabledBorder() {
    if (widget.inputStyle == InputStyle.outline) {
      return OutlineInputBorder(
        borderSide: BorderSide(
          color: context.read<UtilityProvider>().isDarkTheme ||
                  MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Colors.grey.shade700
              : Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(widget.radius),
      );
    } else {
      return UnderlineInputBorder(
        borderSide: BorderSide(
          color: context.read<UtilityProvider>().isDarkTheme ||
                  MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Colors.grey.shade700
              : Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(widget.radius),
      );
    }
  }

  InputBorder _errorBorder() {
    if (widget.inputStyle == InputStyle.outline) {
      return OutlineInputBorder(
        borderSide: const BorderSide(color: AppColor.error),
        borderRadius: BorderRadius.circular(widget.radius),
      );
    } else {
      return UnderlineInputBorder(
        borderSide: const BorderSide(color: AppColor.error),
        borderRadius: BorderRadius.circular(widget.radius),
      );
    }
  }

  InputBorder _focusedErrorBorder() {
    if (widget.inputStyle == InputStyle.outline) {
      return OutlineInputBorder(
        borderSide: const BorderSide(color: AppColor.error),
        borderRadius: BorderRadius.circular(widget.radius),
      );
    } else {
      return UnderlineInputBorder(
        borderSide: const BorderSide(color: AppColor.error),
        borderRadius: BorderRadius.circular(widget.radius),
      );
    }
  }

  InputBorder _focusedBorder() {
    if (widget.inputStyle == InputStyle.outline) {
      return OutlineInputBorder(
        borderSide: const BorderSide(color: AppColor.primary),
        borderRadius: BorderRadius.circular(widget.radius),
      );
    } else {
      return UnderlineInputBorder(
        borderSide: const BorderSide(color: AppColor.primary),
        borderRadius: BorderRadius.circular(widget.radius),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UtilityProvider>(
      builder: (context, utilityProvider, _) {
        return Padding(
          padding: widget.margin ?? const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.labelText != null)
                Padding(
                  padding: widget.inputStyle == InputStyle.outline
                      ? const EdgeInsets.only(bottom: 8)
                      : EdgeInsets.zero,
                  child: Text(
                    widget.labelText!,
                    style: widget.labelStyle ??
                        textStyle.bodyMedium!.copyWith(
                          color: widget.labelTextColor == null &&
                                  (utilityProvider.isDarkTheme ||
                                      MediaQuery.of(context)
                                              .platformBrightness ==
                                          Brightness.dark)
                              ? Colors.white
                              : Colors.black,
                        ),
                  ),
                ),
              Focus(
                onFocusChange: _onFocusChange,
                child: TypeAheadField(
                  builder: (context, controller, focusNode) {
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      autocorrect: false,
                      autofocus: widget.autoFocus,
                      cursorColor: AppColor.primary,
                      decoration: InputDecoration(
                        isCollapsed: true,
                        isDense: true,
                        contentPadding: widget.inputStyle == InputStyle.outline
                            ? const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              )
                            : const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                        disabledBorder: _disabledBorder(),
                        enabledBorder: _enabledBorder(),
                        errorBorder: _errorBorder(),
                        errorStyle: textStyle.bodySmall!
                            .copyWith(color: AppColor.error),
                        filled: true,
                        fillColor: utilityProvider.isDarkTheme ||
                                MediaQuery.of(context).platformBrightness ==
                                    Brightness.dark
                            ? widget.inputStyle == InputStyle.outline
                                ? Colors.grey.shade900
                                : Colors.transparent
                            : Colors.blueGrey[50],
                        focusedBorder: _focusedBorder(),
                        focusedErrorBorder: _focusedErrorBorder(),
                        hintText: widget.hintText,
                        hintStyle: textStyle.bodyMedium!
                            .copyWith(color: Colors.grey, height: 1),
                        prefixIcon: widget.preffixIcon != null
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Icon(widget.preffixIcon, size: 20),
                              )
                            : null,
                        prefixIconColor: tState == TextFieldState.focus
                            ? AppColor.primary
                            : Colors.grey,
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 24, maxHeight: 24),
                        suffixIcon: widget.suffixIcon != null
                            ? InkWell(
                                onTap: widget.onTapSuffixIcon,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Icon(widget.suffixIcon, size: 20),
                                ),
                              )
                            : null,
                        suffixIconColor: tState == TextFieldState.focus
                            ? AppColor.primary
                            : Colors.grey,
                        suffixIconConstraints:
                            const BoxConstraints(minWidth: 24, maxHeight: 24),
                      ),
                      enabled: widget.enabled,
                      inputFormatters: inputFormatters,
                      keyboardType: widget.keyboardType,
                      maxLines: widget.maxLines,
                      obscureText: widget.obsecureText,
                      onChanged: widget.onChanged,
                      readOnly: widget.readOnly,
                      style: textStyle.bodyMedium!.copyWith(height: 1),
                      textAlign: widget.textAlign,
                      textAlignVertical: TextAlignVertical.center,
                      textCapitalization: widget.textCapitalization,
                      textInputAction: widget.textInputAction,
                    );
                  },
                  controller: widget.controller,
                  itemBuilder: widget.itemBuilder,
                  onSelected: widget.onSelected,
                  suggestionsCallback: widget.suggestionsCallback,
                  emptyBuilder: (context) {
                    return const SizedBox();
                  },
                  decorationBuilder: (context, child) {
                    return ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width / 2,
                        maxHeight: MediaQuery.of(context).size.width / 2,
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColor.primary,
                          boxShadow: [
                            BoxShadow(color: Colors.transparent),
                          ],
                        ),
                        child: child,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
