import 'package:flutter/material.dart';
import 'package:responsible_development/common/enum.dart';
import 'package:responsible_development/widgets/inputs/input_primary.dart';

class InputPassword extends StatefulWidget {
  const InputPassword({
    super.key,
    required this.controller,
    this.hintText = 'Password',
    this.inputStyle = InputStyle.outline,
    this.labelText,
    this.margin,
    this.preffixIcon,
    this.validator,
    this.validatorText,
  });

  final TextEditingController controller;
  final String hintText;
  final InputStyle inputStyle;
  final String? labelText;
  final EdgeInsets? margin;
  final IconData? preffixIcon;
  final String? Function(String?)? validator;
  final String? validatorText;

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  String? Function(String? value)? validator;
  String validatorText = '';
  bool obsecureText = true;

  @override
  void initState() {
    super.initState();
    _validator();
    _validatorText();
  }

  _validator() {
    if (widget.validator != null) {
      validator = (value) {
        return widget.validator!(value);
      };
    } else {
      validator = (value) {
        if (value!.isEmpty) {
          return widget.validatorText;
        }

        return null;
      };
      // validator = (value) {
      //   if (!AppUtils.isPasswordValid(password: value!)) {
      //     return validatorText;
      //   }

      //   return null;
      // };
    }
  }

  _validatorText() {
    if (widget.validatorText != null) {
      validatorText = widget.validatorText!;
    } else {
      validatorText = "Field Can't Be Empty";
    }
  }

  _toggleVisible() {
    setState(() {
      obsecureText = !obsecureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InputPrimary(
      controller: widget.controller,
      hintText: widget.hintText,
      labelText: widget.labelText,
      preffixIcon: widget.preffixIcon,
      margin: widget.margin,
      onTapSuffixIcon: _toggleVisible,
      obsecureText: obsecureText,
      suffixIcon: obsecureText ? Icons.visibility_off : Icons.visibility,
      validator: validator,
      validatorText: validatorText,
    );
  }
}
