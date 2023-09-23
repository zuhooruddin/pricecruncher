import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:price_cruncher_new/models/shopping_list.dart';

import '../services/auth_services_new.dart';

class Shop {
  final String id;
  final String name;

  Shop({required this.id, required this.name});
}

class ShopProvider with ChangeNotifier {
  List<Shop> _shopList = [];

  List<Shop> get shopList => _shopList;

  Future<void> fetchShopsFromLocation() async {
    try {
      final userUid = AuthServicesNew().getEmail();
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userUid)
          .collection('shops')
          .get();

      _shopList = querySnapshot.docs.map((doc) {
        final id = doc.id;
        final name = doc.data()['shopName'] as String;
        return Shop(id: id, name: name);
      }).toList();

      notifyListeners();
    } catch (e) {
      // Handle any errors that may occur during the query
      print('Error fetching shops: $e');
    }
  }
}

class ShoppingListProvider with ChangeNotifier {
  List<ShoppingList> _shopList = [];

  List<ShoppingList> get shopList => _shopList;

  Future<void> fetchItemsLists() async {
    try {
      final email = await AuthServicesNew().getEmail();
      final querySnapshot = await FirebaseFirestore.instance
          .collection('itemsList')
          .where('uid', isEqualTo: email)
          .get();

      final collaboratorQuerySnapshot = await FirebaseFirestore.instance
          .collection('itemsList')
          .where('collaborators', isEqualTo: email)
          .get();

      final List<DocumentSnapshot> documents =
          querySnapshot.docs + collaboratorQuerySnapshot.docs;

      _shopList = documents.map((doc) {
        return ShoppingList.fromMap(doc);
      }).toList();

      notifyListeners();
    } catch (e) {
      // Handle any errors that may occur during the query
      print('Error fetching shops: $e');
    }
  }
}
