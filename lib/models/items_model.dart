class AddItem {
  String itemId;
  String itemName;
  String itemDescription;
  String barcode;
  String category;
  double quantity;
  String unit;
  String price;
  String brandName;
  String storeName;
  DateTime dateTime;
  bool bulkPackaging;

  AddItem({
    required this.itemId,
    required this.itemName,
    required this.itemDescription,
    required this.barcode,
    required this.category,
    required this.quantity,
    required this.unit,
    required this.price,
    required this.brandName,
    required this.storeName,
    required this.dateTime,
    required this.bulkPackaging,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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
    };
  }

  factory AddItem.fromMap(Map<String, dynamic> map) {
    return AddItem(
      itemId: map['itemId'] ?? '',
      itemName: map['itemName'] ?? '',
      itemDescription: map['itemDescription'] ?? '',
      barcode: map['barcode'] ?? '',
      category: map['category'] ?? '',
      quantity: map['quantity'] ?? 0,
      unit: map['unit'] ?? '',
      price: map['price'] ?? '',
      brandName: map['brandName'] ?? '',
      storeName: map['storeName'] ?? '',
      bulkPackaging: map['bulkPackaging'] ?? false,
      dateTime: map['dateTime'].toDate() ?? DateTime.now(),
    );
  }
}
