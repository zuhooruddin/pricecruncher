import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:price_cruncher_new/models/usermodel.dart';
import 'package:price_cruncher_new/services/auth_services_new.dart';
import 'package:price_cruncher_new/utils/constants.dart';

class DatabaseServices {
  final _collectionRef = FirebaseFirestore.instance.collection('users');
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> saveFile(String ref, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  //upload image/video to storage
  Future addFileTStorage(File file) async {
    final storage = FirebaseStorage.instance;
    var snapshot = await storage.ref().child(file.path).putFile(file);
    String url = await snapshot.ref.getDownloadURL();
    return url;
  }

  Future saveUserDetails(
    String name,
    String phoneNumber,
    // File profilePic,
  ) async {
    try {
      String? uid = auth.currentUser!.email;
      // File file = File(profilePic.path);
      // String url = await addFileTStorage(file);
      final user = UserModel(
        userName: name,
        userId: uid,
        // profilePic: url,
        phoneNumber: phoneNumber,
        favorites: [],
        invites: [],
      );

      await _collectionRef.doc(uid).set(user.toMap());
    } catch (e) {
      print(e);
      showToast(e.toString(), Colors.red);
    }
  }

  Future<void> editUser(
    String name,
    String phone,
    String profilePic,
  ) async {
    try {
      print('here wo go');
      await FirebaseFirestore.instance
          .collection('users')
          .doc(await AuthServicesNew().getEmail())
          .update({
        'userName': name,
        // 'profilePic': profilePic,
        'phoneNumber': phone,
      });
    } catch (e) {}
  }

  Future<void> addAndRemoveFromFavorites(
    String itemId,
    bool add,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(await AuthServicesNew().getEmail())
          .update({
        'favorites': add
            ? FieldValue.arrayUnion([itemId])
            : FieldValue.arrayRemove([itemId]),
      });
    } catch (e) {}
  }

  Future<void> inviteToCollaborate(
    String uid,
    Map map,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'invites': FieldValue.arrayUnion([map]),
      });
    } catch (e) {}
  }
}
