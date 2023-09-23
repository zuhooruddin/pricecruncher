import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:price_cruncher_new/authentication/toggle_screen.dart';
import 'package:price_cruncher_new/mainApp/homeScreen/Store/comparePrice.dart';
import 'package:price_cruncher_new/mainApp/homeScreen/invite_screen.dart';
import 'package:price_cruncher_new/mainApp/homeScreen/profile_screen.dart';
import 'package:price_cruncher_new/mainApp/homeScreen/settings.dart';
import 'package:price_cruncher_new/providers/language_provider.dart';
import 'package:price_cruncher_new/services/auth_services_new.dart';
import 'package:price_cruncher_new/shared/custom_button.dart';
import 'package:price_cruncher_new/utils/constants.dart';
import 'package:price_cruncher_new/utils/size_confiq.dart';
import 'package:provider/provider.dart';

import '../../shared/custom_appBar.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

enum Language { english, frech }

class _MenuScreenState extends State<MenuScreen> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<ChangeLanguageProvider>(
      builder: (context, provider, child) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBar().buildAppBar(
                title: 'Tools',
                customPopUpButton: PopupMenuButton(
                    onSelected: (value) {
                      if (value == Language.english) {
                        provider.changeLangauge(Locale('en'));
                      } else {
                        provider.changeLangauge(Locale('fr'));
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<Language>>[
                          const PopupMenuItem(
                            value: Language.english,
                            child: Text('English'),
                          ),
                          const PopupMenuItem(
                            value: Language.frech,
                            child: Text('French'),
                          )
                        ])),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(21),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildVerticalSpace(21),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(ComparePrice());
                          },
                          child: buildContainer(
                            'Quick Comparison',
                            'assets/images/menu1.png',
                            getProportionateScreenWidth(60),
                            getProportionateScreenWidth(60),
                          ),
                        ),
                        buildContainer(
                          'Discount Calculator',
                          'assets/images/menu.png',
                          getProportionateScreenWidth(60),
                          getProportionateScreenWidth(60),
                        ),
                      ],
                    ),
                    buildVerticalSpace(21),
                    Text(
                      'Account',
                      style: customHeadingStyle.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: getProportionateScreenWidth(22),
                          color: Colors.black),
                    ),
                    // buildVerticalSpace(21),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(21),
                          vertical: getProportionateScreenWidth(21)),
                      child: Column(
                        children: [
                          CustomButton2(
                              text: 'Profile',
                              function: () => Get.to(ProfileScreen())),
                          CustomButton2(
                              text: 'Settings',
                              function: () => Get.to(Settings())),
                          CustomButton2(
                              text: 'Invites',
                              function: () => Get.to(InviteList())),
                          CustomButton2(
                              text: 'Rate Price Cruncher', function: () {}),
                          CustomButton2(text: 'Help', function: () {}),
                          CustomButton2(
                              text: 'SignOut',
                              function: () async {
                                showLoader(context);

                                await AuthServicesNew().logOut();
                                Navigator.pop(context);
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Toggle();
                                }), (route) => false);
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  Container buildContainer(
      String title, String icon, double width, double height) {
    return Container(
      margin: EdgeInsets.only(right: getProportionateScreenWidth(12)),
      // height: getProportionateScreenWidth(122),
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(11),
          vertical: getProportionateScreenWidth(21)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            color: Colors.grey[300]!,
            blurRadius: 5,
            spreadRadius: 3,
          ),
        ],
        color: grey,
      ),
      child: Column(
        children: [
          Image.asset(
            icon,
            width: width,
            height: height,
          ),
          // Spacer(),
          buildVerticalSpace(12),
          Text(
            title,
            style: customStyle.copyWith(
              color: Colors.black,
              fontSize: getProportionateScreenWidth(10),
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
