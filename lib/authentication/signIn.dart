import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:price_cruncher_new/authentication/resetPassword.dart';
import 'package:price_cruncher_new/mainApp/BottomNavigationBar/bottomNavBar.dart';
import 'package:price_cruncher_new/providers/loader_provider.dart';
import 'package:price_cruncher_new/services/auth_services.dart';
import 'package:price_cruncher_new/services/auth_services_new.dart';
import 'package:price_cruncher_new/shared/custom_auth_textfield.dart';
import 'package:price_cruncher_new/utils/constants.dart';
import 'package:price_cruncher_new/utils/customContainers.dart';
import 'package:provider/provider.dart';

import '../providers/shop_provider.dart';
import '../providers/user_data_provider.dart';
import '../shared/password_field.dart';

class SignIn extends StatefulWidget {
  final VoidCallback? function;
  const SignIn({super.key, this.function});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late TextEditingController emailController;
  late TextEditingController fullNameController;
  late TextEditingController passwordController;
  bool showPassword = true;
  var selected;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    emailController = TextEditingController();
    fullNameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  bool scroll = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Consumer<LoaderProvider>(
          builder: (_, isLoading, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/logo.png',
                        width: Get.width * 0.4,
                        height: Get.height * 0.19,
                      ),
                    ),
                    InkWell(
                        onTap: () async {
                          isLoading.isLoading = true;
                          if (isLoading.isLoading) {
                            showLoader(context);
                          } else {
                            Get.back();
                          }
                          await AuthServices.of(context).signInWithGoogle();
                          isLoading.isLoading = false;
                        },
                        child: customGoogleFbAppleContainer(
                            'Continue with Google', 'google')),
                    sizedBox02,
                    InkWell(
                        onTap: () async {
                          isLoading.isLoading = true;
                          if (isLoading.isLoading) {
                            showLoader(context);
                          } else {
                            Get.back();
                          }
                          await AuthServices.of(context).signInWithFacebook();
                          isLoading.isLoading = false;
                        },
                        child: customGoogleFbAppleContainer(
                            'Continue with Facebook', 'fb')),
                    sizedBox02,
                    customGoogleFbAppleContainer(
                        'Continue with Apple', 'apple'),
                    sizedBox02,
                    customMainHeadingText('Login'),
                    sizedBox01,
                    customSubHeadingText('Please enter the details to login'),
                    sizedBox03,
                    CustomAuthenticationField(
                      controller: emailController,
                      hintText: 'Email',
                      label: 'Email',
                      validation: (value) =>
                          value!.isEmpty ? 'Email is required' : null,
                      inputType: TextInputType.emailAddress,
                    ),
                    sizedBox03,
                    CustomPasswordField(
                      inputType: TextInputType.visiblePassword,
                      controller: passwordController,
                      hintText: 'Password',
                      showPassword: showPassword,
                      validation: (value) =>
                          value!.isEmpty ? 'Password is required' : null,
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    ),
                    sizedBox01,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(const ResetPassword());
                          },
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(
                                color: lightBlue,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                    sizedBox03,
                    customSubmitButtonAuthentication('Login', () async {
                      if (_formKey.currentState!.validate()) {
                        if (emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          try {
                            // isLoading.isLoading = true;
                            showLoader(context);

                            final result = await AuthServicesNew()
                                .signInUserWithEmailAndPassword(
                              emailController.text,
                              passwordController.text,
                            );
                            if (result != null) {
                              await Provider.of<UserDataProvider>(context,
                                      listen: false)
                                  .fetchUser();
                              await Provider.of<ShopProvider>(context,
                                      listen: false)
                                  .fetchShopsFromLocation();
                              await Provider.of<ShoppingListProvider>(context,
                                      listen: false)
                                  .fetchItemsLists();
                              // isLoading.isLoading = false;
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ScreenBottomNavBar()),
                                  (route) => false);
                            } else {
                              Navigator.pop(context);
                              showToast(
                                  'Invalid Credentials or user don\'t exist');
                            }
                          } on Exception catch (e) {
                            // TODO
                            Navigator.pop(context);
                            showToast('Error : $e');
                          }
                        } else {
                          showToast('Enter email and password', Colors.red);
                        }
                      }
                    }),
                    sizedBox02,
                    Divider(
                      color: dividerColor,
                      thickness: 0.5,
                    ),
                    switchAuthSignInSignUp(this.widget.function, 'Sign Up'),
                    sizedBox03,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
