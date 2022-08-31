import 'package:cloud_firestore/cloud_firestore.dart';


CollectionReference order = FirebaseFirestore.instance
    .collection('order')
    .doc()
    .collection('OrderDetails');

Future<void> addOrder(
  String locationProduct,
  String productName,
  String productPrice,
  int quantity,
  String time,
) {
  return order
      .add({
        'locationProduct': locationProduct,
        'productName': productName,
        'productPrice': productPrice,
        'quantity': quantity,
        'time': time,
      })
      .then((value) => print("Order Added"))
      .catchError((error) => print("Failed to add Order: $error"));
}
