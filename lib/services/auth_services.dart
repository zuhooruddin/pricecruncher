import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:price_cruncher_new/authentication/toggle_screen.dart';
import 'package:price_cruncher_new/mainApp/BottomNavigationBar/bottomNavBar.dart';
import 'package:price_cruncher_new/mainApp/homeScreen/homeScreen.dart';
import 'package:price_cruncher_new/models/usermodel.dart';
import 'package:price_cruncher_new/providers/user_provider.dart';
import 'package:price_cruncher_new/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthServices {
  final BuildContext context;

  AuthServices.of(this.context);
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _collectionRef = FirebaseFirestore.instance.collection('users');

  ////////////// Authentication With google //////////////
  Future<void> signInWithGoogle() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        if (userCredential.additionalUserInfo?.isNewUser == true) {
          userProvider.fullName = userCredential.user?.displayName;
          // userProvider.phoneNumber = userCredential.user?.phoneNumber;
          // userProvider.imageUrl = userCredential.user?.photoURL;
          // userProvider.uId = userCredential.user?.uid;
          // print('image url is ${userProvider.imageUrl}');
          // final user = UserModel(
          //     userName: userProvider.user.userName,
          //     userId: userProvider.user.userId,
          //     profilePic: userProvider.user.profilePic,
          //     phoneNumber: userProvider.user.phoneNumber);
          // await _collectionRef.doc(credential.providerId).set(user.toMap());
          Get.off(ScreenBottomNavBar());
        } else {}
      } else {
        Navigator.pop(context);
      }
    } catch (error) {
      Navigator.pop(context);
      showToast(error.toString(), Colors.red);
      debugPrint('google error: ${error.toString()}');
    }
  }

  //////////////// Authentication With Facebook //////////////
  Future<void> signInWithFacebook() async {
    try {
      // Log in with Facebook
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: [
          "public_profile",
          "email",
          "user_birthday",
          "user_hometown",
          "user_location",
        ],
        loginBehavior: LoginBehavior.webOnly,
      );
      // Get the access token
      final OAuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.token);

      // Sign in with Firebase using the Facebook access token
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      print(
          "Facebook Data with Credentials -> ${userCredential.user.toString()}");
      print("Facebook Email  -> ${userCredential.user!.providerData[0].email}");

      if (userCredential.additionalUserInfo?.isNewUser == true) {
        log('Email: ${userCredential.user!.email}');
        Get.off(ScreenBottomNavBar());
      } else {}
    } catch (e) {
      Navigator.pop(context);
      showToast('Facebook login error: $e', Colors.red);
    }
  }

  ///////////////////// Authentication With Apple ////////////////////////
  Future<void> signInWithApple() async {
    try {
      final result = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ],
      );
      log('Given Name -> ${result.givenName}');
      log('Family Name -> ${result.familyName}');
      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: result.identityToken,
        accessToken: result.authorizationCode,
      );
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      log("Apple Data with Credentials -> ${userCredential.user.toString()}");
      log("Apple Email  -> ${userCredential.user!.providerData[0].email}");
      if (userCredential.additionalUserInfo?.isNewUser == true) {
        Get.to(const HomeScreen());
      } else {}
    } catch (e) {
      Navigator.pop(context);
      showToast('Apple login error: $e', Colors.red);
    }
  }

  //////////// Create new account with email and password //////////////
  Future<bool> signUp(String fullName, String phoneNumber, String email,
      String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      showToast(e.message!, Colors.red);
      return false;
    }
  }

///////////////// login User //////////////////
  Future<bool> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message!);
      showToast(e.message!, Colors.red);
      return false;
    } catch (e) {
      showToast(e.toString(), Colors.red);
      debugPrint('An error occurred, please try again later');
      return false;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showToast(
          'A password reset link will be sent if the email provided is for a registered user',
          color2);
    } catch (error) {
      debugPrint(error.toString());
      showToast(error.toString(), Colors.red);
    }
  }

  Future fetchUserData() async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await _collectionRef
          .doc(_auth.currentUser!.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) async {
        if (documentSnapshot.exists) {
          final user = UserModel.fromMap(
              documentSnapshot.data() as Map<String, dynamic>);
          userProvider.user = user;
        }
      });
    } catch (e) {
      showToast(e.toString(), Colors.red);
    }
  }

  ///////// siging out ////////
  Future<void> emailSignOut() async {
    await _auth.signOut().then((value) async {
      FirebaseAuth.instance.idTokenChanges().listen((User? user) {
        if (user == null) {
          showToast('User has been Signout', Colors.red);
          Get.off(const Toggle());
        } else {
          debugPrint('User is signed in!');
        }
      });
    });
  }
}
