import 'package:flutter/material.dart';
import 'package:responsible_development/utils/app_utils.dart';
import 'package:responsible_development/widgets/inputs/input_primary.dart';

class InputTime extends StatefulWidget {
  const InputTime({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.onChanged,
    this.controller,
  });

  final String hintText;
  final String labelText;
  final ValueSetter<TimeOfDay?> onChanged;
  final TextEditingController? controller;

  @override
  State<InputTime> createState() => _InputTimeState();
}

class _InputTimeState extends State<InputTime> {
  TextEditingController controller = TextEditingController();
  TimeOfDay? initialTime;

  @override
  void initState() {
    if (widget.controller != null) {
      controller = widget.controller!;
      initialTime = AppUtils.convertStringToTimeOfDay(controller.text);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InputPrimary(
      controller: controller,
      readOnly: true,
      hintText: widget.hintText,
      labelText: widget.labelText,
      onTap: () async {
        final res = await showTimePicker(
          context: context,
          initialTime: initialTime ?? TimeOfDay.now(),
          initialEntryMode: TimePickerEntryMode.inputOnly,
          helpText: 'Masukkan Waktu',
          confirmText: 'Simpan',
          cancelText: 'Batal',
          hourLabelText: 'Jam',
          minuteLabelText: 'Menit',
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                alwaysUse24HourFormat: true,
              ),
              child: child!,
            );
          },
        );
        widget.onChanged(res);
        if (res != null) {
          controller.text =
              '${res.hour.toString().padLeft(2, '0')}:${res.minute.toString().padLeft(2, '0')}';
        }
        AppUtils.dismissKeyboard();
      },
    );
  }
}
