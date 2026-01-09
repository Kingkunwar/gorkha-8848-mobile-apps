import 'package:flutter/material.dart';

class CheckBoxWidget extends StatelessWidget {
  final bool value;
  final Function(bool?) onChanged;
  final String title;

  const CheckBoxWidget({
    super.key,
    required this.value,
    required this.title,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: value,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: onChanged,

      title: Text(
        title,
      ),
    );
  }
}
