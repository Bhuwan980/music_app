import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  final String value;
  final String label;

  const InfoBox({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.titleMedium),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
