import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_application_2/utils/utils.dart';

class DateTimeTextFieldWidgetForCreateAdminView extends StatefulWidget {
  const DateTimeTextFieldWidgetForCreateAdminView({
    super.key,
    required this.publishAtTextEdtContlr,
  });
  final TextEditingController publishAtTextEdtContlr;
  @override
  State<DateTimeTextFieldWidgetForCreateAdminView> createState() =>
      _DateTimeTextFieldWidgetForCreateAdminViewState();
}

class _DateTimeTextFieldWidgetForCreateAdminViewState
    extends State<DateTimeTextFieldWidgetForCreateAdminView> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.publishAtTextEdtContlr,
      decoration: Utils.commonDecoration(
          hint: 'Enter Publish Date Here? DD/MM/YYYY',
          context: context,
          suffixIcon: const Icon(Icons.calendar_today)),
      onTap: () => _selectDateTime(context),
      readOnly: true,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
    );
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDateTime != null) {
      if (!context.mounted) return;
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime selectedDateTime = DateTime(
          pickedDateTime.year,
          pickedDateTime.month,
          pickedDateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          widget.publishAtTextEdtContlr.text =
              DateFormat('dd/MM/yyyy HH:mm a').format(selectedDateTime);
        });
      }
    }
  }
}
