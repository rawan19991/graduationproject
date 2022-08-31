import 'package:flutter/material.dart';

class AddProductToCart with ChangeNotifier {
  
  List<Map<String, String>> itemId = [];
  addProduct(Map<String, String> id) {
    Map<String, String> item = {'name': id['name']};
    int index = itemId.indexWhere((i) => i['name'] == item['name']);
    print(itemId.indexWhere((i) => i['name'] == item['name']));
    if (index > -1) {
      itemId.removeAt(index);
      itemId.add(id);
    } else {
      itemId.add(id);
    }

    notifyListeners();
  }
}
