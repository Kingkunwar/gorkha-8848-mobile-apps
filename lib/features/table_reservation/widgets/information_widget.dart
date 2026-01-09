import 'package:flutter/material.dart';

class InformationWidget extends StatelessWidget {
  final String keyText;
  final String valueText;
  const InformationWidget({
    super.key,
    required this.keyText,
    required this.valueText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            "$keyText:",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Expanded(
          child: Text(
            valueText,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
