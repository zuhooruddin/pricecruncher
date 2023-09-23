import 'package:cloud_firestore/cloud_firestore.dart';

class ShoppingList {
  String listName;
  String listDescription;
  List<String> outstandingItems;
  List<String> totalItems;
  String docId;
  num price;
  String collaborator;
  String uid;
  ShoppingList({
    required this.listName,
    required this.listDescription,
    required this.outstandingItems,
    required this.totalItems,
    required this.price,
    required this.docId,
    required this.collaborator,
    required this.uid,
  });

  factory ShoppingList.fromMap(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> map = documentSnapshot.data() as Map<String, dynamic>;
    return ShoppingList(
      listName: map['listName'] ?? '',
      listDescription: map['listDescription'] ?? '',
      outstandingItems: List<String>.from((map['outstandingItems'])),
      totalItems: List<String>.from(map['totalItems']),
      price: map['price'] ?? '',
      docId: documentSnapshot.id,
      collaborator: map['collaborators'] ?? '',
      uid: map['uid'] ?? '',
    );
  }
}
