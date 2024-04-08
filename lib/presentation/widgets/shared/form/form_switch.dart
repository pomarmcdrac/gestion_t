import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gestion_t/config/theme/app_theme.dart';

class FormSwitch extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const FormSwitch({
    super.key, 
    required this.initialValue, 
    required this.onChanged
  });

  @override
  FormSwitchState createState() => FormSwitchState();
}

class FormSwitchState extends State<FormSwitch> {
  bool isCompleted = false;

  @override
  void didUpdateWidget (FormSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      setState(() => isCompleted = widget.initialValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AutoSizeText(
          'Completado', 
          style: TextStyle(
            color: AppTheme().principal,
          ),
          maxLines: 1,
          minFontSize: 10,
          maxFontSize: 14,
        ),
        Switch(
          value: isCompleted, 
          onChanged: (value) {
            setState(() {
              isCompleted = value;
            });
            widget.onChanged(value);
          },
        ),
      ],
    );
  }
}