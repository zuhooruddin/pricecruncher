import 'dart:io';

import 'package:flutter/material.dart';
import 'package:price_cruncher_new/providers/loader_provider.dart';
import 'package:price_cruncher_new/providers/user_data_provider.dart';
import 'package:price_cruncher_new/services/auth_services_new.dart';
import 'package:price_cruncher_new/services/database_services.dart';
import 'package:price_cruncher_new/utils/constants.dart';
import 'package:price_cruncher_new/utils/customContainers.dart';
import 'package:provider/provider.dart';

import '../mainApp/BottomNavigationBar/bottomNavBar.dart';
import '../providers/shop_provider.dart';
import '../shared/custom_auth_textfield.dart';
import '../shared/password_field.dart';

class SignUp extends StatefulWidget {
  final VoidCallback? function;
  const SignUp({super.key, this.function});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late TextEditingController emailController;
  late TextEditingController fullNameController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController phoneNumberController;
  bool showPassword = true;
  bool showConfirmPassword = true;
  File? image;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneNumberController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
    fullNameController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  void selectImage() async {
    File? pickedImage = await pickImageFromGallery();
    if (pickedImage != null) {
      image = pickedImage;
      setState(() {});
    }
  }

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
                    customLogoInCenter(),
                    customMainHeadingText('Create an account'),
                    // customSubHeadingText('Please enter the details to login'),
                    sizedBox02,
                    // customImagePickerContainer(image, () {
                    //   selectImage();
                    // }),
                    sizedBox02,
                    CustomAuthenticationField(
                      inputType: TextInputType.text,
                      controller: fullNameController,
                      hintText: 'Full Name',
                      label: "Full Name",
                      validation: (value) =>
                          value!.isEmpty ? 'This field is required' : null,
                      // inputType: TextInputType.emailAddress,
                    ),
                    sizedBox02,
                    CustomAuthenticationField(
                      inputType: TextInputType.phone,
                      controller: phoneNumberController,
                      hintText: 'Phone Number',
                      label: "Phone Number",
                      // validation: (value) =>
                      //     value!.isEmpty ? 'This field is required' : null,
                      // inputType: TextInputType.emailAddress,
                    ),
                    sizedBox02,
                    CustomAuthenticationField(
                      inputType: TextInputType.emailAddress,
                      controller: emailController,
                      hintText: 'Email',
                      label: "Email",
                      validation: (value) =>
                          value!.isEmpty ? 'This field is required' : null,
                      // inputType: TextInputType.emailAddress,
                    ),
                    sizedBox02,
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
                    sizedBox02,
                    CustomPasswordField(
                      inputType: TextInputType.visiblePassword,
                      controller: confirmPasswordController,
                      hintText: 'Confirm Password',
                      showPassword: showConfirmPassword,
                      validation: (value) => value!.isEmpty
                          ? 'Confirm your password is required'
                          : null,
                      onPressed: () {
                        setState(() {
                          showConfirmPassword = !showConfirmPassword;
                        });
                      },
                    ),
                    sizedBox02,
                    customCheckBoxContainer((value) {
                      setState(() {
                        checkBox = !checkBox;
                      });
                    }, checkBox),
                    sizedBox03,
                    customSubmitButtonAuthentication('Sign Up', () async {
                      if (_formKey.currentState!.validate()) {
                        // Check if confirm password is not empty
                        if (passwordController.text ==
                            confirmPasswordController.text) {
                          isLoading.isLoading = true;
                          showLoader(context);
                          var result = await AuthServicesNew()
                              .createUserWithEmailAndPassword(
                            emailController.text,
                            passwordController.text,
                          );
                          if (result != null) {
                            await DatabaseServices().saveUserDetails(
                              fullNameController.text,
                              phoneNumberController.text,
                              // image!,
                            );
                            await Provider.of<ShopProvider>(context,
                                    listen: false)
                                .fetchShopsFromLocation();
                            await Provider.of<UserDataProvider>(context,
                                    listen: false)
                                .fetchUser();
                            await Provider.of<ShoppingListProvider>(context,
                                    listen: false)
                                .fetchItemsLists();
                            isLoading.isLoading = false;
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ScreenBottomNavBar()),
                                (route) => false);
                          } else {
                            isLoading.isLoading = false;
                            showToast(
                              'Invalid Credential or user already exist',
                              Colors.red,
                            );
                          }
                        } else {
                          showToast('Passwords do not match', Colors.red);
                        }
                      }
                    }),
                    sizedBox02,
                    Divider(
                      color: dividerColor,
                      thickness: 0.5,
                    ),
                    switchAuthSignInSignUp(this.widget.function, 'Sign In'),
                    sizedBox03,
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

  bool checkBox = false;
}
