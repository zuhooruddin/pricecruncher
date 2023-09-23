import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:price_cruncher_new/services/auth_services_new.dart';

import '../models/usermodel.dart';

class UserDataProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  // Fetch user data from Firestore by document ID
  Future<void> fetchUser() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(await AuthServicesNew().getEmail())
          .get();

      if (snapshot.exists) {
        final userData = snapshot.data() as Map<String, dynamic>;
        _user = UserModel.fromMap(userData);
        notifyListeners();
      } else {
        // Handle the case where the document does not exist
      }
    } catch (e) {
      // Handle any errors that occur during the fetch
      print('Error fetching user data: $e');
    }
  }
}
