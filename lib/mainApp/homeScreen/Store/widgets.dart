import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:price_cruncher_new/utils/constants.dart';
import 'package:price_cruncher_new/utils/customContainers.dart';

import '../../../utils/size_confiq.dart';

Row customTopRowWithScreenNameAndCrownImage(String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 28,
          fontWeight: FontWeight.w700,
        ),
      ),
      Image.asset(
        'assets/images/crown.png',
        width: getProportionateScreenWidth(38),
        height: getProportionateScreenWidth(38),
      ),
    ],
  );
}

Container customContainerOfPriceInPriceComapreScreenWithTextField(
  String text,
  TextEditingController controller,
) {
  return Container(
    width: Get.width * 0.44,
    padding: const EdgeInsets.only(top: 10, bottom: 20, left: 10, right: 10),
    decoration: BoxDecoration(
        color: const Color(0xFFF7F5F5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 0.50, color: const Color(0xFFF2F2F2))),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        sizedBox01,
        Container(
          width: Get.width * 0.4,
          height: Get.height * 0.05,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.50, color: const Color(0xFFF1F1F1)),
            borderRadius: BorderRadius.circular(6),
          ),
          child: customTextFieldSmall(controller, null, null),
        )
      ],
    ),
  );
}

Container customContainerQuickComparison(String text) {
  return Container(
    width: Get.width * 0.44,
    padding: const EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
        color: const Color.fromRGBO(61, 139, 61, 1),
        borderRadius: BorderRadius.circular(6)),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
