import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:price_cruncher_new/mainApp/homeScreen/invite_screen.dart';
import 'package:price_cruncher_new/services/auth_services_new.dart';

class LIstServices {
  final _collectionRef = FirebaseFirestore.instance.collection('users');
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addListToFirebase(
    String name,
    String description,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('itemsList').doc().set({
        'listName': name,
        'listDescription': description,
        'outstandingItems': [],
        'totalItems': [],
        'price': 0,
        'collaborators': '',
        'uid': await AuthServicesNew().getEmail(),
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> addItemToBuy(
    String itemId,
    String shoppingListId,
    num price,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('itemsList')
          .doc(shoppingListId)
          .update({
        'outstandingItems': FieldValue.arrayUnion([itemId]),
        'price': FieldValue.increment(price),
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> removeCollaborator(
    String shoppingListId,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('itemsList')
          .doc(shoppingListId)
          .update({
        'collaborators': '',
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> addItemsToBuy(
    List itemIds,
    String shoppingListId,
    num price,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('itemsList')
          .doc(shoppingListId)
          .update({
        'outstandingItems': FieldValue.arrayUnion(itemIds),
        'price': FieldValue.increment(price),
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<DocumentSnapshot> fetchListData(String docId) {
    return FirebaseFirestore.instance
        .collection('itemsList')
        .doc(docId)
        .snapshots();
  }

  Future<void> addItemToBought(
    List itemIds,
    String shoppingListId,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('itemsList')
          .doc(shoppingListId)
          .update({
        'outstandingItems': FieldValue.arrayRemove(itemIds),
        'totalItems': FieldValue.arrayUnion(itemIds),
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> addItemToBuyAgain(
    List itemIds,
    String shoppingListId,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('itemsList')
          .doc(shoppingListId)
          .update({
        'totalItems': FieldValue.arrayRemove(itemIds),
        'outstandingItems': FieldValue.arrayUnion(itemIds),
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> acceptRequestForCollaboration(
    String shoppingListId,
    InvitationModel map,
    String collaboratorId,
  ) async {
    try {
      await _collectionRef.doc(await AuthServicesNew().getEmail()).update({
        'invites': FieldValue.arrayRemove([map.toMap()]),
      });
      await FirebaseFirestore.instance
          .collection('itemsList')
          .doc(shoppingListId)
          .update({
        'collaborators': collaboratorId,
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
