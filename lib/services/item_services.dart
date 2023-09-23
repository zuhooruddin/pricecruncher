import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:price_cruncher_new/mainApp/BottomNavigationBar/bottomNavBar.dart';
import 'package:price_cruncher_new/models/items_model.dart';
import 'package:price_cruncher_new/services/auth_services_new.dart';
import 'package:uuid/uuid.dart';

class ItemServices {
  final _collectionRef = FirebaseFirestore.instance.collection('users');
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future addItems({
    required BuildContext context,
    required String itemName,
    required String category,
    required DateTime dateTime,
    String? itemDescription,
    String? barcode,
    double? quantity,
    String? unit,
    String? price,
    String? brandName,
    String? storeName,
    bool? bulkPackaging,
  }) async {
    final itemId = await Uuid().v1();
    // DateTime time = DateTime.now();
    try {
      final item = AddItem(
        itemId: itemId,
        itemName: itemName,
        itemDescription: itemDescription ?? '',
        barcode: barcode ?? '',
        category: category,
        quantity: quantity ?? 0,
        unit: unit ?? '',
        price: price ?? '',
        brandName: brandName ?? '',
        dateTime: dateTime,
        storeName: storeName ?? '',
        bulkPackaging: bulkPackaging ?? false,
      );

      await _collectionRef
          .doc(auth.currentUser!.email)
          .collection('items')
          .doc(itemId)
          .set(item.toMap());
      // Get.off(ScreenBottomNavBar());
      Navigator.pushReplacementNamed(context, ScreenBottomNavBar.routeName,
          arguments: item);
    } catch (e) {
      print(e);
    }
  }

  ////////// getting items from Firestore /////////
  Stream getItemsStream() {
    print('We are inside the main function');
    return _collectionRef
        .doc(auth.currentUser!.email)
        .collection('items')
        .orderBy('dateTime', descending: true)
        .snapshots();
  }

  Stream<List<AddItem>> getItemsStreamModels() {
    try {
      final stream = _collectionRef
          .doc(auth.currentUser!.email)
          .collection('items')
          .orderBy('itemName',
              descending: false) // Sort by itemName in ascending order
          .snapshots();

      return stream.map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          final data = doc.data();
          return AddItem.fromMap(data);
        }).toList()
          ..sort((a, b) => a.itemName.toLowerCase().compareTo(
              b.itemName.toLowerCase())); // Sort the list by itemName
      });
    } catch (e) {
      // Handle any errors that occur during the operation.
      print('Error fetching activities: $e');
      return Stream.value(
          []); // Return an empty stream or handle the error as needed.
    }
  }

  Stream<List<AddItem>> getItemsStreamModelsFiltered(List selectedCategories,
      String minPrice, String maxPrice, List favItems) {
    try {
      final stream = _collectionRef
          .doc(auth.currentUser!.email)
          .collection('items')
          .where('price', isGreaterThanOrEqualTo: minPrice)
          .where('price', isLessThanOrEqualTo: maxPrice)
          .where('category', whereIn: selectedCategories)
          .orderBy('itemName',
              descending: false) // Sort by itemName in ascending order
          .snapshots();

      return stream.map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          final data = doc.data();
          return AddItem.fromMap(data);
        }).toList()
          ..sort((a, b) => a.itemName.toLowerCase().compareTo(
              b.itemName.toLowerCase())); // Sort the list by itemName
      });
    } catch (e) {
      // Handle any errors that occur during the operation.
      print('Error fetching activities: $e');
      return Stream.value(
          []); // Return an empty stream or handle the error as needed.
    }
  }

  Stream<QuerySnapshot<Object?>> getFilteredItemsStream(String searchQuery) {
    print('We are inside the filtered function');
    Query query = _collectionRef
        .doc(auth.currentUser!.email)
        .collection('items')
        .orderBy('dateTime', descending: true);

    if (searchQuery.isNotEmpty) {
      // Add a where clause to filter items by the itemName field
      query = query
          .where('itemName', isGreaterThanOrEqualTo: searchQuery)
          .where('itemName', isLessThanOrEqualTo: searchQuery + '\uf8ff');
    }

    return query.snapshots();
  }

  ////////// getting items from Firestore /////////
  Stream<QuerySnapshot<Map<String, dynamic>>> getItemsStreamForStore(
      String storeName) {
    return _collectionRef
        .doc(auth.currentUser!.email)
        .collection('items')
        .where('storeName', isEqualTo: storeName)
        .orderBy('dateTime', descending: true)
        .snapshots();
  }

  ///////////// updating an Item /////////////
  Future<void> updateItem(
    String itemName,
    String category,
    DateTime dateTime,
    String itemDescription,
    String barcode,
    double quantity,
    String unit,
    double price,
    String brandName,
    String storeName,
    bool bulkPackaging,
    String itemId,
  ) async {
    await _collectionRef
        .doc(auth.currentUser!.email)
        .collection('items')
        .doc(itemId)
        .update({
      'itemId': itemId,
      'itemName': itemName,
      'itemDescription': itemDescription,
      'barcode': barcode,
      'category': category,
      'quantity': quantity,
      'unit': unit,
      'price': price,
      'brandName': brandName,
      'storeName': storeName,
      'dateTime': dateTime,
      'bulkPackaging': bulkPackaging,
    });
  }

//////////// Deleting an Item /////////////
  Future<void> deleteItem(itemId) async {
    try {
      await _collectionRef
          .doc(auth.currentUser!.email)
          .collection('items')
          .doc(itemId)
          .delete();
    } catch (e) {
      print(e);
    }
  }

  Stream<List<AddItem>> fetchUsersThroughIdsStream(List docIds) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(AuthServicesNew().getEmail())
        .collection('items')
        .snapshots()
        .map(
          (querySnapshot) => querySnapshot.docs
              .where((doc) => docIds.contains(doc.id))
              .map((doc) => AddItem.fromMap(doc.data()))
              .toList(),
        );
  }

  Stream<List<AddItem>> fetchAllItemsThroughStream(
      List<String> excludedItemIds) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(AuthServicesNew().getEmail())
        .collection('items')
        .where('itemId', whereNotIn: excludedItemIds)
        .snapshots()
        .map(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => AddItem.fromMap(doc.data()))
              .toList(),
        );
  }
}
