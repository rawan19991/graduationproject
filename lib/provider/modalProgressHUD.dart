import 'package:flutter/material.dart';
class ProgressProvider with ChangeNotifier{
  
  bool inAsyncCall=false;
  isLoding(bool val){
    inAsyncCall=val;
    notifyListeners();
  }
}