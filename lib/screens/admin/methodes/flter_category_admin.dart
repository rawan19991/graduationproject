
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/filter_category.dart';
import '../../../widget/sign_up.dart';
import '../show_product.dart';

class FilterCategory extends StatefulWidget {
  
  static const String id = 'FilterCategory';

  @override
  _FilterCategoryState createState() => _FilterCategoryState();
}

class _FilterCategoryState extends State<FilterCategory> {
  final items = [
    "Electrical device",
    "Kitchen equipment",
    "cups",
    "cleaning",
    "kitchen accessorise",
    "All Product"
  ];
  final itemProv = ["Electrical device", "Kitchen equipment", "cups", "shirt", "kitchen accessorise", null];

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              items[index],
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 350,
              child: CupertinoPicker(
                looping: true,
                itemExtent: 64,
                children: items
                    .map(
                      (item) => Center(
                        child: Text(item),
                      ),
                    )
                    .toList(),
                onSelectedItemChanged: (item) {
                  setState(() {
                    index = item;
                  });
                  Provider.of<FilterCategoryItem>(context, listen: false)
                      .newCategory(itemProv[item]);
                },
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SignUp(() {
              Navigator.pushNamed(context, ShowProduct.id);
            }, "filter", 150.0)
          ],
        ),
      ),
    );
  }
}
