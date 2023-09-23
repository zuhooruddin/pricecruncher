import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServicesNew {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference userReference =
      FirebaseFirestore.instance.collection('Users');

  //create user with email and password
  Future createUserWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign in user with existing email and password
  Future signInUserWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      return user;
    } catch (e) {
      print(e);
      print('error');
      return null;
    }
  }

  String? getNumber() {
    return _auth.currentUser?.phoneNumber;
  }

  Future signUpUsingPhoneNumber(
      String phoneNumber, dynamic onSent, dynamic onFailed) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: onFailed,
        codeSent: onSent,
        codeAutoRetrievalTimeout: (String verificationID) {},
        timeout: Duration(seconds: 60),
      );
    } catch (e) {
      print('we have an error');
    }
  }

  Future verifyPhoneNumber(String smsCode, String verificationId) async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      final user = await _auth.signInWithCredential(phoneAuthCredential);
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  //get uid
  getUid() {
    return _auth.currentUser?.uid;
  }

  //get user
  getUser() {
    if (_auth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  //get email
  getEmail() {
    return _auth.currentUser!.email;
  }

  getName() {
    return _auth.currentUser!.displayName;
  }

  //logOut
  logOut() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        await _auth.signOut();
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> doesEmailExist(String email) async {
    try {
      List<String> signInMethods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      return signInMethods.isNotEmpty;
    } catch (e) {
      print("Error checking if email exists: $e");
      return false;
    }
  }

// google signOut
}
