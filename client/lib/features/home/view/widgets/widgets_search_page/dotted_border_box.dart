import 'package:flutter/material.dart';

class DottedBorderBox extends StatelessWidget {
  final IconData icon;
  final String text;

  const DottedBorderBox({required this.icon, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.grey, style: BorderStyle.solid, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.grey),
          const SizedBox(height: 5),
          Text(text, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
