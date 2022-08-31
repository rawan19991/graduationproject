import 'package:flutter/cupertino.dart';

class CounterOrder with ChangeNotifier {
  
  int counter = 1;

  addProduct() {
    counter++;
    notifyListeners();
  }

  deleteProduct() {
    if (counter > 0) {
      counter--;
      notifyListeners();
    }
  }
}
