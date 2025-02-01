import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?)?
      validator; // Correctly specify the validator type

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.isPassword = false,
    this.validator, // Initialize the validator
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        prefixIcon: Icon(icon),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      obscureText: isPassword,
      controller: controller,
      validator: validator ??
          (val) {
            // Use the provided validator or a default one
            if (val == null || val.isEmpty) {
              return "Field cannot be empty";
            }
            return null;
          },
    );
  }
}
