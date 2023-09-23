import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:price_cruncher_new/utils/size_confiq.dart';
import 'package:price_cruncher_new/utils/constants.dart';
import 'package:price_cruncher_new/shared/custom_appBar.dart';

class VipScreen extends StatefulWidget {
  const VipScreen({super.key});

  @override
  State<VipScreen> createState() => _VipScreenState();
}

class _VipScreenState extends State<VipScreen> {
  File? image;
  Future getImage() async {
    var pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar2()
          .buildAppBar2(title: 'VIP', context: context, fromVip: true),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(22)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildVerticalSpace(21),
            GestureDetector(
              onTap: () {
                // Get.to(CrunchPriceAddNewItem());
              },
              child: Container(
                decoration: BoxDecoration(
                  color: orange,
                  borderRadius: BorderRadius.circular(
                    getProportionateScreenWidth(20),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(12),
                    vertical: getProportionateScreenWidth(12)),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/offer_icon.png',
                      width: getProportionateScreenWidth(134),
                      height: getProportionateScreenWidth(134),
                    ),
                    // buildHorizontalSpace(21),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Ad Free',
                            style: customHeadingStyle.copyWith(
                              fontSize: getProportionateScreenWidth(24),
                              fontWeight: FontWeight.w700,
                              color: whiter,
                            ),
                          ),
                          buildVerticalSpace(4),
                          Container(
                            height: getProportionateScreenWidth(26),
                            width: getProportionateScreenWidth(156),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  getProportionateScreenWidth(20)),
                              color: whiter,
                            ),
                            child: Center(
                              child: Text(
                                'Active until 30th June 2023',
                                style: customStyle.copyWith(
                                  fontSize: getProportionateScreenWidth(8),
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          buildVerticalSpace(11),
                          Text(
                            '3 days left',
                            style: customStyle.copyWith(
                              fontSize: getProportionateScreenWidth(10),
                              fontWeight: FontWeight.w600,
                              color: whiter,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            buildVerticalSpace(12),
            buildContainer(
                'Remove Ads Forever',
                'Permanently  remove ads from the app with a one time purchase',
                'assets/images/block_add.png',
                false),
            buildVerticalSpace(12),
            buildContainer(
                'Remove Ads For 1 week',
                'Remove ads from the app for one week by watching three video ads',
                'assets/images/ad_block2.png',
                true),
          ],
        ),
      ),
    );
  }

  GestureDetector buildContainer(
      String title, String description, String icon, bool fromSecond) {
    return GestureDetector(
      onTap: () {
        // Get.to(CrunchPriceAddNewItem());
      },
      child: Container(
        decoration: BoxDecoration(
          color: greyF6,
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(20),
          ),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(12),
            vertical: getProportionateScreenWidth(12)),
        child: Row(
          children: [
            Image.asset(
              icon,
              width: getProportionateScreenWidth(134),
              height: getProportionateScreenWidth(134),
            ),
            // buildHorizontalSpace(21),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: customHeadingStyle.copyWith(
                      fontSize: getProportionateScreenWidth(16),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  buildVerticalSpace(4),
                  Text(
                    description,
                    style: customStyle.copyWith(
                      fontSize: getProportionateScreenWidth(10),
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  buildVerticalSpace(fromSecond ? 11 : 0),
                  Text(
                    '(0/3 watched)',
                    style: customStyle.copyWith(
                      fontSize: getProportionateScreenWidth(10),
                      fontWeight: FontWeight.w400,
                      color: darkGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
