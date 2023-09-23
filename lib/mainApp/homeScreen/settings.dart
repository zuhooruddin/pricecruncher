import 'package:flutter/material.dart';
import 'package:price_cruncher_new/utils/constants.dart';
import 'package:price_cruncher_new/utils/size_confiq.dart';
import 'package:price_cruncher_new/mainApp/homeScreen/contact_us.dart';
import '../../shared/custom_appBar.dart';
import 'package:get/get.dart';

import 'change_password.dart';
import 'delete_account.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar2()
          .buildAppBar2(title: 'Settings', context: context, fromVip: false),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(17)),
        child: Column(
          children: [
            buildVerticalSpace(21),
            SettingsButton(
              title: 'Change Password',
              onTap: () {
                Get.to(ChangePassword());
              },
            ),
            SettingsButton(
              title: 'Delete Account & Data',
              onTap: () {
                Get.to(DeleteAccount());
              },
            ),
            SettingsButton(
              title: 'Contact Us',
              onTap: () {
                Get.to(ContactUs());
              },
            ),
            SettingsButton(
              title: 'Log Out',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const SettingsButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
          bottom: getProportionateScreenWidth(12),
        ),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              getProportionateScreenWidth(5),
            ),
            border: Border.all(
              color: buttonsBorderGrey,
              width: 0.5,
            )),
        padding: EdgeInsets.symmetric(horizontal: 21, vertical: 18),
        child: Text(
          title,
          style: customStyle.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: getProportionateScreenWidth(14),
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
