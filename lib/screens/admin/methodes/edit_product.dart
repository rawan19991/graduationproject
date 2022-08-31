import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

CollectionReference product = FirebaseFirestore.instance.collection('product');

Future<void> updateProduct(String id, TextEditingController name,

    TextEditingController price,
    TextEditingController description,
    TextEditingController category,
    TextEditingController image,) {
  return product
      .doc(id)
      .update({
        'category': category.text.toString().trim(),
    'description': description.text.toString().trim(),
    'image':image.text.toString().trim(),
    'name': name.text.toString().trim(),
    'price': price.text.toString().trim(),

  })
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to update user: $error"));
}
