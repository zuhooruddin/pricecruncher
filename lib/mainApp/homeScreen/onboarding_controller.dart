import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController{
  var selectedPageIndex = 0.obs;
  bool get isLastPage => selectedPageIndex.value == onboardingPages.length - 1;
  var pageController = PageController();

  forwardAction(){
    if(isLastPage){

    }else{
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
    }
  }
  List<OnboardingComponent> onboardingPages = [
    OnboardingComponent(
        "assets/images/onBoardingOne.png",
        "Compare Prices Like a Pro!",
      'Collaborate with Friends and Family for Stress-Free Shopping! Collaborate with Friends and Family for Stress-Free Shopping! Collaborate with Friends and Family for Stress-Free Shopping!',
    ),
    OnboardingComponent(
        "assets/images/onBoardingTwo.png",
        "Effortlessly Manage Your Shopping Lists!",
      'Collaborate with Friends and Family for Stress-Free Shopping! Collaborate with Friends and Family for Stress-Free Shopping! Collaborate with ',
    ),
    OnboardingComponent(
        "assets/images/onBoardingThree.png",
        "Collaborate with Friends and Family",
      'Collaborate with Friends and Family for Stress-Free Shopping! Collaborate with Friends and Family for Stress-Free Shopping! Collaborate with ',
    ),

  ];
}

class OnboardingComponent{
  final imagesAsset;
  final title;
  final description;
  OnboardingComponent(this.imagesAsset,this.title,this.description);
}