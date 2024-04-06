import 'package:flutter/material.dart';
import 'package:gestion_t/config/config.dart';

class InputText extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final String labelText;
  final String hintText;

  const InputText({
    super.key, 
    required this.type, 
    required this.labelText, 
    required this.hintText, 
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppTheme().fondo,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
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
        onChanged: (value) {
          controller.text = value;
        }
      ),
    );
  }
}