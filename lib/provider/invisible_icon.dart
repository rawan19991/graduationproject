import 'package:flutter/cupertino.dart';

class InvisibleIcon with ChangeNotifier {
  
  bool invisible = true;
  void inContact(TapDownDetails details) {
    invisible = false;
    notifyListeners();
  }

  void outContact(TapUpDetails details) {
    invisible = true;

    notifyListeners();
  }
}
