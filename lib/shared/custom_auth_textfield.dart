import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CustomAuthenticationField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String label;
  final TextInputType? inputType;
  final FormFieldValidator<String>? validation;
  final bool? readOnly;

  CustomAuthenticationField({
    required this.controller,
    required this.hintText,
    required this.label,
    this.inputType,
    this.validation,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType ?? TextInputType.name,
      style: const TextStyle(fontSize: 16),
      validator: validation,
      readOnly: readOnly!,
      decoration: InputDecoration(
        labelText: label, // Set the label text
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: lightBorderColorTextField),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: lightBorderColorTextField),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: lightBorderColorTextField),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 11, horizontal: 21),
        hintStyle: TextStyle(
          color: hintTextColor,
          fontWeight: FontWeight.w300,
          fontSize: 16,
        ),
      ),
    );
  }
}
