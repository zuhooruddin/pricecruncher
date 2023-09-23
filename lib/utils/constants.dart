import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:price_cruncher_new/utils/size_confiq.dart';

Color black = Colors.black;
Color white = Colors.white;
Color switchAuth = const Color.fromRGBO(92, 92, 92, 1);
Color switchAuth2 = const Color.fromRGBO(98, 163, 215, 1);
Color borderColorGoogleFacebookAppleContainer =
    const Color.fromRGBO(146, 145, 145, 1);
Color backgroundColorGoogleFacebookAppleContainer =
    const Color.fromRGBO(245, 245, 245, 1);
Color textColorGoogleFacebookAppleContainer =
    const Color.fromRGBO(69, 69, 69, 1);
Color lightBlue = const Color.fromRGBO(98, 163, 215, 1);
Color lightBorderColorTextField = const Color.fromRGBO(218, 218, 218, 1);
Color hintTextColor = const Color.fromRGBO(203, 203, 203, 1);
Color circleAvatarOnBoarding = const Color.fromRGBO(180, 221, 255, 1);
Color onBoardingDarkText = const Color.fromRGBO(27, 27, 27, 1);
Color onBoardingLightText = const Color.fromRGBO(115, 115, 115, 1);
Color dividerColor = const Color.fromRGBO(216, 216, 216, 1);
Color checkBoxBackGroundColor = const Color.fromRGBO(243, 243, 243, 1);
Color crunchPriceBackGroundColor = const Color.fromRGBO(214, 227, 221, 1);
Color crunchPriceTextColor = const Color.fromRGBO(183, 198, 210, 1);
Color lightGrey = Color(0xffECECEC);
Color darker = Color(0xff272727);
Color darkGrey = Color(0xff838383);
Color textFieldBorderColor = Color(0xffDADADA);
Color darkerBlack = Color(0xff060606);
Color buttonsBorderGrey = Color(0xffE0E0E0);
Color greyF6 = Color(0xfff6f6f6);
Color orange = Color(0xffFFAA3E);
Color whiter = Color(0xffffffff);
Color onboardingCircleColor = Color(0xff62A3D7);
Color greyish = Color(0xffFCFCFC);
Color grey = Color(0xffFBFBFB);
const color2 = Color.fromRGBO(61, 139, 61, 1);

TextStyle customHeadingStyle = TextStyle(
  color: Colors.black,
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.w800,
);

TextStyle customStyle = TextStyle(
  color: Colors.black,
  fontSize: getProportionateScreenWidth(12),
  fontWeight: FontWeight.w600,
);
SizedBox sizedBox02 = SizedBox(
  height: Get.height * 0.02,
);
SizedBox sizedBox025 = SizedBox(
  height: Get.height * 0.025,
);
SizedBox sizedBox03 = SizedBox(
  height: Get.height * 0.03,
);
SizedBox sizedBox05 = SizedBox(
  height: Get.height * 0.05,
);
SizedBox sizedBox01 = SizedBox(
  height: Get.height * 0.01,
);
SizedBox sizedBox015 = SizedBox(
  height: Get.height * 0.015,
);
SizedBox sizedBox1 = SizedBox(
  height: Get.height * 0.1,
);
SizedBox sizedBox08 = SizedBox(
  height: Get.height * 0.08,
);
SizedBox sizedBox075 = SizedBox(
  height: Get.height * 0.075,
);
SizedBox sizedBox005 = SizedBox(
  height: Get.height * 0.005,
);
SizedBox sizedBox002Width = SizedBox(
  width: Get.width * 0.02,
);
SizedBox sizedBox001Width = SizedBox(
  width: Get.width * 0.01,
);
TextStyle onBoardingDarkTextTheme() => TextStyle(
    color: onBoardingDarkText, fontSize: 24, fontWeight: FontWeight.w700);
TextStyle onBoardingLightTextTheme() => TextStyle(
    color: onBoardingLightText, fontSize: 22, fontWeight: FontWeight.w300);

TextStyle bottomNavBarTextStyle({bool selected = false}) {
  return TextStyle(
      color: selected ? Colors.green : Colors.white,
      fontWeight: selected ? FontWeight.bold : FontWeight.normal,
      fontSize: selected ? 9 : 7,
      overflow: TextOverflow.ellipsis);
}

const roundedRectangleBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(12),
    topRight: Radius.circular(12),
  ),
);

showToast(String msg, [Color? backgroundColor]) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor ?? Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

void showLoader(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Center(
          child: const CircularProgressIndicator(
        color: Colors.white,
      ));
    },
  );
}

Future<File?> pickImageFromGallery() async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showToast(e.toString(), Colors.red);
  }
  return image;
}
