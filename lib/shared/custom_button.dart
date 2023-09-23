import 'package:flutter/material.dart';
import 'package:price_cruncher_new/utils/constants.dart';
import 'package:price_cruncher_new/utils/size_confiq.dart';

class CustomButton extends StatelessWidget {
  final double? width, fontSize, borderRadius;
  final double height;
  final VoidCallback onTap;
  final Color? color, titleColor;
  final String title;
  final FontWeight? fontWeight;

  // Constructor with named parameters and default values
  CustomButton({
    this.width = 102.0,
    this.height = 30.0,
    required this.onTap,
    this.color = Colors.black,
    required this.title,
    this.fontSize,
    this.titleColor,
    this.fontWeight,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 5.0),
          ),
        ),
        child: Text(
          title,
          style: customStyle.copyWith(
              color: titleColor ?? Colors.white,
              fontSize: fontSize ?? getProportionateScreenWidth(8),
              fontWeight: fontWeight ?? FontWeight.w400),
        ),
      ),
    );
  }
}

class CustomButton2 extends StatelessWidget {
  final String text;
  final VoidCallback function;
  const CustomButton2({super.key, required this.text, required this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        margin: EdgeInsets.only(
          bottom: getProportionateScreenWidth(21),
        ),
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(16),
        ),
        decoration: BoxDecoration(
          color: grey,
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(15),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 1),
              color: Colors.grey[350]!,
              blurRadius: 5,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenWidth(18),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
