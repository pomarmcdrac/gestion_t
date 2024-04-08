import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gestion_t/config/config.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const SubmitButton({
    super.key, 
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme().principal,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: AutoSizeText(
        buttonText,
        style: TextStyle(color: AppTheme().claro),
        maxLines: 1,
        minFontSize: 10,
        maxFontSize: 20,
      ),
    );
  }
}