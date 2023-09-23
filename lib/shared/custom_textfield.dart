import 'package:flutter/material.dart';
import 'package:price_cruncher_new/utils/constants.dart';
import 'package:price_cruncher_new/utils/size_confiq.dart';

class CustomTextField extends StatelessWidget {
  final dynamic onChanged;
  final String? hintText;
  final dynamic validation;
  final dynamic prefixIcon;
  final int? maxLines;
  final int? minLines;
  final String? initialValue;
  final dynamic keyBoardType;
  final dynamic controller;
  final FocusNode? focusNode;
  final Color? fillColor,
      hintColor,
      enabledColor,
      focusedColor,
      textColor,
      errorBorder,
      focusedErrorBorder;
  final VoidCallback? onTap;
  final double? borderRadius;
  CustomTextField(
      {Key? key,
      this.focusNode,
      this.onTap,
      this.textColor,
      this.focusedColor,
      this.enabledColor,
      this.hintColor,
      this.borderRadius,
      this.fillColor,
      this.controller,
      this.keyBoardType,
      this.hintText,
      this.prefixIcon,
      this.initialValue,
      this.onChanged,
      this.maxLines,
      this.minLines,
      this.validation,
      this.errorBorder,
      this.focusedErrorBorder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        onTap: onTap ?? () {},
        validator: validation,
        onChanged: onChanged,
        controller: controller,
        maxLines: maxLines ?? 1,
        focusNode: focusNode,
        style: TextStyle(
          color: textColor ?? darkerBlack,
          fontSize: getProportionateScreenWidth(16),
        ),
        initialValue: initialValue ?? null,
        keyboardType: keyBoardType ?? TextInputType.text,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: enabledColor ?? textFieldBorderColor, width: 1.0),
            borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: focusedColor ?? Colors.black, width: 1.0),
            borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: errorBorder ?? Colors.red, width: 1.0),
            borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: focusedErrorBorder ?? textFieldBorderColor, width: 1.0),
            borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
          ),
          fillColor: fillColor ?? Colors.transparent,
          filled: true,
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          prefixIcon: prefixIcon,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 16,
            color: hintColor ?? darkGrey,
          ),
        ),
      ),
    );
  }
}
