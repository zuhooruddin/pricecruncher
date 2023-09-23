import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:price_cruncher_new/models/usermodel.dart';
import 'package:price_cruncher_new/providers/user_data_provider.dart';
import 'package:price_cruncher_new/services/database_services.dart';
import 'package:price_cruncher_new/shared/custom_appBar.dart';
import 'package:price_cruncher_new/utils/constants.dart';
import 'package:price_cruncher_new/utils/size_confiq.dart';
import 'package:provider/provider.dart';

import '../../shared/custom_auth_textfield.dart';
import 'change_password.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? image;
  Future getImage() async {
    var pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
        log(image!.path);
      });
    }
  }

  String? profileUrl;

  @override
  void initState() {
    userProvider = Provider.of<UserDataProvider>(context, listen: false);
    user = userProvider!.user;
    userName.text = user!.userName!;
    phone.text = user!.phoneNumber!;
    email.text = FirebaseAuth.instance.currentUser!.email!;
    profileUrl = user!.profilePic!;
    // TODO: implement initState
    super.initState();
  }

  final userName = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();

  UserDataProvider? userProvider;
  UserModel? user;

  bool scroll = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: scroll
          ? Container(
              height: 51,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : BottomNavbarButton(
              onTap: () async {
                try {
                  showLoader(context);

                  if (image != null) {
                    File file = File(image!.path);
                    profileUrl = await DatabaseServices().addFileTStorage(file);
                  }

                  await DatabaseServices().editUser(
                    userName.text,
                    phone.text,
                    profileUrl!,
                  );
                  await userProvider?.fetchUser();
                  Navigator.pop(context);
                  Navigator.pop(context);
                } catch (e) {
                  Navigator.pop(context);
                  showToast('Error $e');
                }

                // Get.to(Settings());
              },
              title: 'Save Changes',
            ),
      backgroundColor: Colors.white,
      appBar: CustomAppBar2()
          .buildAppBar2(title: 'Profile', context: context, fromVip: false),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(17)),
        child: Column(
          children: [
            buildVerticalSpace(21),
            Stack(
              children: [
                image != null
                    ? CircleAvatar(
                        radius: getProportionateScreenWidth(49),
                        backgroundImage: FileImage(image!),
                      )
                    : CircleAvatar(
                        radius: getProportionateScreenWidth(49),
                        backgroundImage: NetworkImage(profileUrl ?? ''),
                      ),
                Positioned(
                  child: GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 7,
                            color: Colors.grey,
                            spreadRadius: 1,
                          )
                        ],
                        shape: BoxShape.circle,
                      ),
                      width: getProportionateScreenWidth(35),
                      height: getProportionateScreenWidth(35),
                      padding: EdgeInsets.all(getProportionateScreenWidth(7)),
                      child: Image.asset(
                        'assets/icons/edit.png',
                      ),
                    ),
                  ),
                  bottom: 0,
                  right: 0,
                ),
              ],
            ),
            buildVerticalSpace(41),
            CustomAuthenticationField(
              controller: userName,
              hintText: 'User Name',
              label: 'User Name', // Add the label
              validation: (value) =>
                  value!.isEmpty ? 'User Name is required' : null,
              inputType: TextInputType.emailAddress,
            ),
            buildVerticalSpace(11),
            CustomAuthenticationField(
              controller: phone,
              hintText: 'Phone Number',
              label: 'Phone Number', // Add the label

              validation: (value) =>
                  value!.isEmpty ? 'Email is required' : null,
              inputType: TextInputType.emailAddress,
            ),
            buildVerticalSpace(11),
            CustomAuthenticationField(
              controller: email,
              readOnly: true,
              hintText: 'Email',
              label: 'Email', // Add the label

              validation: (value) =>
                  value!.isEmpty ? 'Email is required' : null,
              inputType: TextInputType.emailAddress,
            ),
            buildVerticalSpace(11),
          ],
        ),
      ),
    );
  }
}
