import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference product = FirebaseFirestore.instance.collection('product');

Future<void> deleteProduct(String id) {
  
  return product
      .doc(id)
      .delete()
      .then((value) => print("User Deleted"))
      .catchError((error) => print("Failed to delete user: $error"));
}
