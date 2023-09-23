import 'package:flutter/material.dart';
import 'package:price_cruncher_new/models/usermodel.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel();

  UserModel get user => _user;

  set user(UserModel value) {
    _user = value;
    notifyListeners();
  }

  String? get fullName => _user.userName;
  set fullName(String? value) {
    _user.userName = value;
    notifyListeners();
  }

  String? get phoneNumber => _user.phoneNumber;
  set phoneNumber(String? value) {
    _user.phoneNumber = value;
    notifyListeners();
  }

  String? get imageUrl => _user.phoneNumber;
  set imageUrl(String? value) {
    _user.profilePic = value;
    notifyListeners();
  }

  String? get uId => _user.phoneNumber;
  set uId(String? value) {
    _user.userId = value;
    notifyListeners();
  }
}
