import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: non_constant_identifier_names
Stream<QuerySnapshot> FilterCategory(int index) {
  
  switch (index) {
    case 1:
      return FirebaseFirestore.instance
          .collection('product')
          .where('category', isEqualTo: 'Electrical device')
          .snapshots();
      break;
    case 2:
      return FirebaseFirestore.instance
          .collection('product')
          .where('category', isEqualTo: 'Kitchenequipment')
          .snapshots();

      break;
    case 3:
      return FirebaseFirestore.instance
          .collection('product')
          .where('category', isEqualTo: 'kitchen accessorise')
          .snapshots();

      break;
    case 4:
      return FirebaseFirestore.instance
          .collection('product')
          .where('category', isEqualTo: 'cleaning')
          .snapshots();

      break;
    case 5:
      return FirebaseFirestore.instance
          .collection('product')
          .where('category', isEqualTo: 'cups')
          .snapshots();

      break;
    default:
      return FirebaseFirestore.instance.collection('product').snapshots();
  }
}
