import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:price_cruncher_new/shared/custom_button.dart';
import 'package:price_cruncher_new/shared/custom_textfield.dart';
import 'package:price_cruncher_new/utils/size_confiq.dart';

import '../../shared/custom_appBar.dart';
import '../../utils/constants.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String? email;
  Future resetPassword() async {
    showLoader(context);
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      Navigator.pop(context);
      Navigator.pop(context);
      showToast('Password Reset Mail Sent');
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showToast(e.toString());
    }
  }

  final emailController = TextEditingController();

  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbarButton(
        onTap: () async {
          if (emailController.text == '' || emailController.text.isEmpty) {
            showToast('Kindly enter your email');
          } else {
            await resetPassword();
          }
        },
        title: 'Reset Password',
      ),
      backgroundColor: Colors.white,
      appBar: CustomAppBar2().buildAppBar2(
          title: 'Change Password',
          context: context,
          fontSize: getProportionateScreenWidth(24),
          fromVip: false),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(22)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildVerticalSpace(21),
            Text(
              'Enter your email here. A password reset link will be sent to you on your registered email.',
              style: customStyle.copyWith(
                fontSize: getProportionateScreenWidth(16),
                fontWeight: FontWeight.w300,
                color: darkGrey,
              ),
              textAlign: TextAlign.start,
            ),
            buildVerticalSpace(41),
            CustomTextField(
              hintText: 'your email here....',
              controller: emailController,
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavbarButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const BottomNavbarButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(17),
          vertical: getProportionateScreenWidth(31)),
      child: CustomButton(
        onTap: onTap,
        title: title,
        width: double.infinity,
        height: getProportionateScreenWidth(50),
        fontWeight: FontWeight.w400,
        fontSize: getProportionateScreenWidth(18),
        borderRadius: getProportionateScreenWidth(10),
      ),
    );
  }
}
