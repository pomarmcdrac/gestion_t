import 'package:flutter/material.dart';
import 'package:gestion_t/config/config.dart';
import 'package:intl/intl.dart';

class InputDate extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final String labelText;
  final String hintText;
  final Size size;

  const InputDate({
    super.key, 
    required this.type, 
    required this.labelText, 
    required this.hintText, 
    required this.controller,
    required this.size
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.4,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppTheme().fondo,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        enableInteractiveSelection: false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          border: const UnderlineInputBorder(borderSide: BorderSide.none),
          labelText: labelText,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14
          ),
        ),
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode()); 
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year - 100),
            lastDate: DateTime(DateTime.now().year + 100),
            initialEntryMode: DatePickerEntryMode.calendarOnly,
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: AppTheme().datePickerTheme,
                child: child!,
              );
            },
          );
          if (picked != null) {
            controller.text = DateFormat('yyyy-MM-dd').format(picked);
          }
        },
      ),
    );
  }
}