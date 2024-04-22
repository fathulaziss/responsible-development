import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsible_development/utils/app_utils.dart';
import 'package:responsible_development/widgets/inputs/input_primary.dart';

class InputDate extends StatefulWidget {
  const InputDate({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.onChanged,
  });

  final String hintText;
  final String labelText;
  final ValueSetter<DateTime?> onChanged;

  @override
  State<InputDate> createState() => _InputDateState();
}

class _InputDateState extends State<InputDate> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return InputPrimary(
      controller: controller,
      readOnly: true,
      hintText: widget.hintText,
      labelText: widget.labelText,
      onTap: () async {
        final res = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2023),
          lastDate: DateTime(2100),
          initialEntryMode: DatePickerEntryMode.calendarOnly,
        );
        widget.onChanged(res);
        if (res != null) {
          controller.text = DateFormat('dd/MM/yyyy').format(res);
        }
        AppUtils.dismissKeyboard();
      },
    );
  }
}
