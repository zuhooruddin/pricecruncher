import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:price_cruncher_new/authentication/toggle_screen.dart';
import 'package:price_cruncher_new/utils/constants.dart';
import 'package:price_cruncher_new/utils/size_confiq.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_controller.dart';

class PageViewScreen extends StatelessWidget {
  final _controller = OnboardingController();

  _storeOnboardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: EdgeInsets.only(top: getProportionateScreenWidth(31)),
              height: SizeConfig.screenHeight * 0.7,
              child: PageView.builder(
                  controller: _controller.pageController,
                  onPageChanged: _controller.selectedPageIndex,
                  itemCount: _controller.onboardingPages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(40),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SizedBox(height: getProportionateScreenHeight(40)),
                          Image.asset(
                            _controller.onboardingPages[index].imagesAsset,
                            width: getProportionateScreenWidth(210.4),
                            height: getProportionateScreenWidth(320.4),
                          ),
                          SizedBox(height: getProportionateScreenHeight(31)),
                          Text(
                            _controller.onboardingPages[index].title,
                            style: TextStyle(
                              fontFamily: "SF Pro Display",
                              fontSize: getProportionateScreenWidth(24),
                              fontWeight: FontWeight.w700,
                              color: Color(0xff1B1B1B),
                              height: getProportionateScreenHeight(28) /
                                  getProportionateScreenWidth(24),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: getProportionateScreenHeight(11)),

                          Text(
                            _controller.onboardingPages[index].description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "SF Pro Text",
                              fontSize: getProportionateScreenWidth(16),
                              fontWeight: FontWeight.w300,
                              color: Color(0xff737373),
                              height: getProportionateScreenHeight(24) /
                                  getProportionateScreenWidth(18),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            Spacer(),
            Padding(
                padding:
                    EdgeInsets.only(bottom: getProportionateScreenWidth(31)),
                child: GestureDetector(
                  onTap: () async {
                    if (_controller.isLastPage) {
                      await _storeOnboardInfo();
                      Get.offAll(Toggle());
                    } else {
                      _controller.forwardAction();
                    }
                  },
                  child: Container(
                    width: getProportionateScreenWidth(74),
                    height: getProportionateScreenWidth(74),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: onboardingCircleColor,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 0),
                          color: onboardingCircleColor,
                          blurRadius: 7,
                          spreadRadius: 1,
                        )
                      ],
                    ),
                    child: Icon(
                      Icons.arrow_right_alt,
                      color: white,
                      size: 50,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
