import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:price_cruncher_new/utils/size_confiq.dart';
import 'package:price_cruncher_new/shared/custom_textfield.dart';
import '../../utils/constants.dart';
import '../../shared/custom_appBar.dart';
import 'change_password.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  File? image;
  Future getImage() async {
    var pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavbarButton(
        onTap: () {},
        title: 'Send',
      ),
      backgroundColor: Colors.white,
      appBar: CustomAppBar2().buildAppBar2(
          title: 'Contact Us',
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
              'Have a question? Hit us up and one of our team members will get back to you shortly',
              style: customStyle.copyWith(
                fontSize: getProportionateScreenWidth(16),
                fontWeight: FontWeight.w300,
                color: darkGrey,
              ),
              textAlign: TextAlign.start,
            ),
            buildVerticalSpace(41),
            CustomTextField(
              hintText: 'Your message',
              maxLines: 10,
            ),
          ],
        ),
      ),
    );
  }
}
