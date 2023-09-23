import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:price_cruncher_new/utils/constants.dart';
import 'package:price_cruncher_new/utils/customContainers.dart';

class AccountLocked extends StatefulWidget {
  const AccountLocked({super.key});

  @override
  State<AccountLocked> createState() => _AccountLockedState();
}

class _AccountLockedState extends State<AccountLocked> {
  late TextEditingController emailController;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                sizedBox03,
                customBackButtonOnTopRight(),
                Image.asset(
                  'assets/images/resetPassword.png',
                  height: Get.height * 0.4,
                  width: Get.width * 0.6,
                ),
                customMainHeadingText('Account Locked'),
                sizedBox01,
                customSubHeadingText(
                    'You have entered your password incorrectly 3 times. To continue using your account, you must reset your password'),
                sizedBox03,
                customTextFieldAuthentication(
                  emailController,
                  'Email',
                  TextInputType.emailAddress,
                  (value) => value!.isEmpty ? 'This field is required' : null,
                ),
                sizedBox08,
                customSubmitButtonAuthentication('Reset Password', () {}),
                sizedBox02,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
