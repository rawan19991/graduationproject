// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/addProductToCart.dart';
import 'homePage.dart';

class CartPage extends StatefulWidget {
  static const String id = 'CartPage';

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var totalPrice = 0;
  var totalServices = 0;
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final nameController = TextEditingController();
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    AlertDialog alert = AlertDialog(
        title: Text('Complete the order'),
        content:SingleChildScrollView (
          child: Container(
            padding: EdgeInsets.all(0),
            height: MediaQuery.of(context).size.height * .26,
            child: Expanded(
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(hintText: "Your name"),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(hintText: "Your phone"),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: addressController,
                    decoration: InputDecoration(hintText: "Address"),
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: <Widget>[
          
          FlatButton(
            color: Colors.green,
            textColor: Colors.white,
            child: Text('Done'),
            onPressed: () async {
              var users = FirebaseFirestore.instance.collection('order').doc();
              await users.set({
                'name': nameController.text.toString().trim(),
                'email': emailController.text.toString().trim(),
                'address': addressController.text.toString().trim(),
                'time': now.hour.toString() +
                    ":" +
                    now.minute.toString() +
                    ":" +
                    now.second.toString()
              });
              Provider.of<AddProductToCart>(context, listen: false)
                  .itemId
                  .forEach((product) {
                users.collection('OrderDetails').add({
                  'quantity': product['quantity'],
                  'locationProduct': product['location'],
                  'productName': product['name'],
                  'productPrice': product['price'],
                  'time': product['time'],
                });
              });
              Provider.of<AddProductToCart>(context, listen: false).itemId = [];
              Navigator.pop(context);
            },
          )
        ]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(.1),
        leading: InkWell(
          onTap: () {
            Navigator.pushNamed(context, HomePage.id);
          },
          child: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.black.withOpacity(.5),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 1.0),
              child: Icon(
                Icons.delete,
                color: Colors.black,
                size: 25,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  "My Order",
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Overlock',
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .6,
                child: ListView(
                  children:
                      Provider.of<AddProductToCart>(context, listen: false)
                          .itemId
                          .map((product) {
                    totalPrice += int.parse(product['price']) *
                        int.parse(product['quantity']);
                    totalServices += int.parse(product['quantity']) * 10;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20)),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .16,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Container(
                                child: Align(
                                  child: Image.asset(
                                    product['location'],
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left:8.0,right:12.0 ,top:8.0,bottom: 8.0),
                              width: MediaQuery.of(context).size.width * .41,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product['name'],
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Overlock',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        product['description'].length > 10
                                            ? product['description']
                                                    .substring(0, 10) +
                                                '...'
                                            : product['description'],
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(.5),
                                          fontSize: 15,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Text(
                                            '\$${int.parse(product['price'])}'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: Text(
                                "${product['quantity']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Delivery services :",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "\$$totalServices",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total :",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "\$$totalPrice",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Checkout",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        height: 50,
                        width: MediaQuery.of(context).size.width * .9,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
