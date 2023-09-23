import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:price_cruncher_new/services/auth_services_new.dart';

class ShopServices {
  CollectionReference usersReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> createShop(String shopName) async {
    await usersReference
        .doc(await AuthServicesNew().getEmail())
        .collection('shops')
        .doc()
        .set({
      'shopName': shopName,
    });
  }
}
