import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:price_cruncher_new/mainApp/homeScreen/vip_screen.dart';
import 'package:price_cruncher_new/utils/constants.dart';
import 'package:price_cruncher_new/utils/size_confiq.dart';

class CustomAppBar {
  AppBar buildAppBar({
    required String title,
    PopupMenuButton? customPopUpButton,
  }) {
    return AppBar(
      // centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        title,
        // textAlign: TextAlign.center,
        style: TextStyle(
          color: black,
          fontSize: getProportionateScreenWidth(28),
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        if (customPopUpButton != null) customPopUpButton,
        InkWell(
          onTap: () {
            Get.to(VipScreen());
          },
          child: Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(10)),
            child: Image.asset(
              "assets/icons/crown.png",
              width: getProportionateScreenWidth(38),
              height: getProportionateScreenWidth(38),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomAppBar4 {
  AppBar buildAppBar({
    required String title,
    PopupMenuButton? customPopUpButton,
  }) {
    return AppBar(
      // centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        title,
        // textAlign: TextAlign.center,
        style: TextStyle(
          color: black,
          fontSize: getProportionateScreenWidth(28),
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        if (customPopUpButton != null) customPopUpButton,
        InkWell(
          onTap: () {
            Get.to(VipScreen());
          },
          child: Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(10)),
            // child: Image.asset(
            //   "assets/icons/crown.png",
            //   width: getProportionateScreenWidth(38),
            //   height: getProportionateScreenWidth(38),
            // ),
          ),
        ),
      ],
    );
  }
}

class CustomAppBar2 {
  AppBar buildAppBar2({
    required String title,
    required BuildContext context,
    double? fontSize,
    required bool fromVip,
  }) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Image.asset(
            'assets/icons/back.png',
            width: getProportionateScreenWidth(12),
            height: getProportionateScreenWidth(12),
          ),
        ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: black,
            fontSize: fontSize ?? getProportionateScreenWidth(28),
            fontWeight: FontWeight.w700,
          )),
      actions: [
        fromVip
            ? SizedBox()
            : InkWell(
                onTap: () {
                  Get.to(VipScreen());
                },
                child: Padding(
                  padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                  child: Image.asset(
                    "assets/icons/crown.png",
                    width: getProportionateScreenWidth(38),
                    height: getProportionateScreenWidth(38),
                  ),
                ),
              ),
      ],
    );
  }
}

class CustomAppBar3 {
  AppBar buildAppBar2(
      {required String title,
      required BuildContext context,
      double? fontSize,
      required bool fromVip}) {
    return AppBar(
      // centerTitle: true,
      leading: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(5)),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: CircleAvatar(
            backgroundColor: lightGrey,
            radius: getProportionateScreenWidth(13),
            child: Image.asset(
              'assets/icons/back.png',
              width: getProportionateScreenWidth(12),
              height: getProportionateScreenWidth(12),
            ),
          ),
        ),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          color: black,
          fontSize: fontSize ?? getProportionateScreenWidth(28),
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        fromVip
            ? SizedBox()
            : InkWell(
                onTap: () {
                  Get.to(VipScreen());
                },
                child: Padding(
                  padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                  child: Image.asset(
                    "assets/icons/crown.png",
                    width: getProportionateScreenWidth(38),
                    height: getProportionateScreenWidth(38),
                  ),
                ),
              ),
      ],
    );
  }
}
