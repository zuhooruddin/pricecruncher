import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:price_cruncher_new/providers/loader_provider.dart';
import 'package:price_cruncher_new/services/auth_services.dart';
import 'package:price_cruncher_new/utils/constants.dart';
import 'package:price_cruncher_new/utils/customContainers.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
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
      body: Consumer<LoaderProvider>(
        builder: (_, isLoading, child) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                    customMainHeadingText('Reset Password'),
                    sizedBox01,
                    customSubHeadingText(
                        'A link to reset your password will be sent on your registered email address'),
                    sizedBox03,
                    customTextFieldAuthentication(
                      emailController,
                      'Email',
                      TextInputType.emailAddress,
                      (value) =>
                          value!.isEmpty ? 'Please Email is required' : null,
                    ),
                    sizedBox08,
                    customSubmitButtonAuthentication('Reset Password', () {
                      if (_formKey.currentState!.validate()) {
                        isLoading.isLoading = true;
                        if (isLoading.isLoading) {
                          showLoader(context);
                        } else {
                          Navigator.pop(context);
                        }
                        AuthServices.of(context)
                            .resetPassword(emailController.text.trim())
                            .then((value) {
                          Navigator.pop(context);
                        });
                      }
                    }),
                    sizedBox02,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
