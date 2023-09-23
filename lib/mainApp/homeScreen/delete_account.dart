import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:price_cruncher_new/shared/custom_textfield.dart';
import 'package:price_cruncher_new/utils/size_confiq.dart';

import '../../authentication/toggle_screen.dart';
import '../../shared/custom_appBar.dart';
import '../../utils/constants.dart';
import 'change_password.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbarButton(
        onTap: () {
          if (email == null || password == null) {
            showToast('Enter email and password to continue');
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Warning'),
                    content: Text('This cant be undone'),
                    actions: [
                      TextButton(onPressed: () {}, child: Text('Cancel')),
                      TextButton(
                          onPressed: () async {
                            await deleteUser(email!, password!);
                          },
                          child: Text('Delete')),
                    ],
                  );
                });
          }
        },
        title: 'Delete account',
      ),
      backgroundColor: Colors.white,
      appBar: CustomAppBar2().buildAppBar2(
          title: 'Delete Account',
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
              'This step is irreversible. All your account data will be deleted along with your account. To confirm, enter your email & password.',
              style: customStyle.copyWith(
                fontSize: getProportionateScreenWidth(16),
                fontWeight: FontWeight.w300,
                color: darkGrey,
              ),
              textAlign: TextAlign.start,
            ),
            buildVerticalSpace(41),
            CustomTextField(
              hintText: 'email',
              onChanged: (val) {
                setState(() {
                  email = val;
                });
              },
            ),
            buildVerticalSpace(12),
            CustomTextField(
              hintText: 'password',
              onChanged: (val) {
                setState(() {
                  password = val;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future deleteUser(String email, String password) async {
    print('Deleting');
    try {
      showLoader(context);
      User user = await _auth.currentUser!;
      print('User created');
      AuthCredential credentials =
          EmailAuthProvider.credential(email: email, password: password);
      UserCredential result = await user.reauthenticateWithCredential(
          credentials); // called from database class
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.email)
          .delete();
      await FirebaseFirestore.instance
          .collection('itemsList')
          .where('uid', isEqualTo: _auth.currentUser!.email)
          .get()
          .then((snapshot) {
        for (var doc in snapshot.docs) {
          doc.reference.delete();
        }
      });
      print('Realtime deleted');
      await result.user?.delete();

      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return Toggle();
      }), (route) => false);
      print('User deleted');
      showToast(
          'Your account and data has been deleted from price cruncher database');
      return true;
    } catch (e) {
      Navigator.pop(context);
      showToast('Error $e');
      print('errorrrrr');
      print(e.toString());
      return null;
    }
  }
}
