import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CustomPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? inputType;
  final bool showPassword;
  final FormFieldValidator<String>? validation;
  final Function()? onPressed;

  CustomPasswordField({
    required this.controller,
    required this.hintText,
    this.inputType,
    required this.showPassword,
    required this.validation,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: showPassword,
      validator: validation,
      keyboardType: inputType ?? TextInputType.name,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: IconButton(
          padding: const EdgeInsets.only(left: 6),
          icon: Icon(
            showPassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: Color.fromRGBO(224, 224, 224, 1),
          ),
          onPressed: onPressed,
        ),
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
        contentPadding: EdgeInsets.symmetric(vertical: 11,horizontal: 21),
        hintStyle: TextStyle(
          color: hintTextColor,
          fontWeight: FontWeight.w300,
          fontSize: 16,
        ),
      ),
    );
  }
}
