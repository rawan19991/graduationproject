// ignore_for_file: missing_required_param

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/product.dart';
import '../../provider/filter_category.dart';
import '../../widget/ShowProduct_list.dart';
import 'admin_panel.dart';
import 'edit_product.dart';
import 'methodes/flter_category_admin.dart';
import 'methodes/delete_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowProduct extends StatefulWidget {
  static const String id = 'ShowProduct';

  @override
  _ShowProductState createState() => _ShowProductState();
}

class _ShowProductState extends State<ShowProduct> {
   Stream<QuerySnapshot> _productStream;
  @override
  void initState() {
    super.initState();
    if (Provider.of<FilterCategoryItem>(context, listen: false).category ==
        null) {
      _productStream =
          FirebaseFirestore.instance.collection('product').snapshots();
    } else {
      _productStream = FirebaseFirestore.instance
          .collection('product')
          .where('category',
              isEqualTo: Provider.of<FilterCategoryItem>(context, listen: false)
                  .category)
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, FilterCategory.id);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                Icons.filter_list_outlined,
                color: Colors.black.withOpacity(.5),
              ),
            ),
          ),
        ],
        leading: InkWell(
          onTap: () {
            Navigator.pushNamed(context, AdminPanel.id);
          },
          child: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.black.withOpacity(.5),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Shopping Product",
          style: TextStyle(
              color: Colors.black, fontFamily: 'Overlock', fontSize: 25),
        ),
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _productStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data();
              return showCategory(
                  name: data['name'],
                  des: data['description'],
                  image: data['image'],
                  functionEdit: () {
                    Navigator.pushNamed(
                      context,
                      EditProduct.id,
                      arguments: {
                        'product': Product(
                          name: data['name'],
                          price: data['price'],
                          description: data['description'],
                          category:  data['description'],
                          image: data['image'], favorite: null, 
                        ),
                        'productId':document.id
                      },
                    );

                  },functionDelete: ()async{
                    await deleteProduct(document.id);
              }
                  );
            }).toList(),
          );
        },
      ),
    );
    
  }
}
