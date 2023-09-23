import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:price_cruncher_new/authentication/toggle_screen.dart';
import 'package:price_cruncher_new/mainApp/BottomNavigationBar/bottomNavBar.dart';
import 'package:price_cruncher_new/mainApp/homeScreen/onboarding.dart';
import 'package:price_cruncher_new/providers/shop_provider.dart';
import 'package:price_cruncher_new/providers/user_data_provider.dart';
import 'package:price_cruncher_new/utils/size_confiq.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/constants.dart';

int? viewed;

Future _initApp() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  viewed = prefs.getInt('onBoard');
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 2), () => _checkUser());
    });
  }

  Future _checkUser() async {
    await _initApp();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      log('inside is not null');
      await Provider.of<UserDataProvider>(context, listen: false).fetchUser();
      await Provider.of<ShopProvider>(context, listen: false)
          .fetchShopsFromLocation();
      await Provider.of<ShoppingListProvider>(context, listen: false)
          .fetchItemsLists();
      // Get.to(ScreenBottomNavBar());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ScreenBottomNavBar()),
          (route) => false);
    } else {
      log('inside is null');
      // Get.to(PageViewScreen());
      Navigator.pushAndRemoveUntil(
          context,
          // MaterialPageRoute(builder: (context) => Toggle()),
          MaterialPageRoute(
              builder: (context) => viewed != 0 ? PageViewScreen() : Toggle()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Image.asset(
          'assets/logo.png',
          width: Get.width * 0.65,
        ),
      ),
    );
  }
}
