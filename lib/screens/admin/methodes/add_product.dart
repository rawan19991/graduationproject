import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

CollectionReference product = FirebaseFirestore.instance.collection('product');

Future<void> addProduct(
  
  TextEditingController name,
  TextEditingController price,
  TextEditingController description,
  TextEditingController category,
  TextEditingController image,
) {
  // Call the user's CollectionReference to add a new user
  return product
      .add({
        'name': name.text.toString().trim(), // John Doe
        'price': price.text.toString().trim(), // Stokes and Sons
        'description': description.text.toString().trim(),
        'category': category.text.toString().trim(),
        'image': image.text.toString().trim(),
        'Favorit': "false", // 42
// 42
// 42
// 42
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}
