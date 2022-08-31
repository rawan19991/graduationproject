import 'package:flutter/material.dart';

class FilterCategoryItem with ChangeNotifier {
  
   String category;
   String categoryUser;

  newCategory(String newCategory) {
    category = newCategory;
    notifyListeners();
  }

  newCategoryUser(String newCategory) {
    categoryUser = newCategory;
    notifyListeners();
  }
}
