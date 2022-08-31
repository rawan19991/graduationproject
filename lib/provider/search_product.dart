import 'package:flutter/cupertino.dart';

class Search with ChangeNotifier {
  
   String textSearch ;
  newText(String text) {
    textSearch = text;
    notifyListeners();
  }
}