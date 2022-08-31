
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/product.dart';
import '../../../provider/addProductToCart.dart';
import '../../../provider/counter_order.dart';
import '../homePage.dart';

class ProductDetails extends StatefulWidget {
  
  static const String id = 'ProductDetails';

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pushNamed(context, HomePage.id);
          },
          child: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 7),
              child: Image.asset(
                args.image,
                height: MediaQuery.of(context).size.height * .3,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(args.name,
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'CrimsonText')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 45,
                  width: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.black.withOpacity(.2))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: InkWell(
                          onTap: () {
                            Provider.of<CounterOrder>(context, listen: false)
                                .deleteProduct();
                            args.quantity = Provider.of<CounterOrder>(context,
                                    listen: false)
                                .counter;
                          },
                          child: Icon(
                            Icons.minimize,
                            size: 30,
                          ),
                        ),
                      ),
                      Text(
                        '${Provider.of<CounterOrder>(
                          context,
                        ).counter}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          Provider.of<CounterOrder>(context, listen: false)
                              .addProduct();
                          args.quantity =
                              Provider.of<CounterOrder>(context, listen: false)
                                  .counter;
                        },
                        child: Icon(
                          Icons.add,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    "\$99",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 20,
                ),
                child: Text(
                  "About the product",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
              ),
              child: Text(
                args.description,
                style: TextStyle(
                    fontSize: 15, color: Colors.black.withOpacity(.5)),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70, left: 25),
                child: Container(
                  child: args.favorite == true
                      ? Icon(
                          Icons.favorite,
                          size: 30,
                          color: Colors.red,
                        )
                      : Icon(
                          Icons.favorite_border,
                          size: 30,
                        ),
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.black.withOpacity(.1))),
                ),
              ),
              InkWell(
                onTap: () {

                  Provider.of<AddProductToCart>(context, listen: false)
                      .addProduct({
                    'name': args.name,
                    'price': args.price,
                    'description': args.description,
                    'category': args.category,
                    'location': args.image,
                    'quantity':
                        "${Provider.of<CounterOrder>(context, listen: false).counter}",
                    'id': args.id,
                    'time':now.hour.toString() + ":" + now.minute.toString() + ":" + now.second.toString()
                  });
                  var snackBar = SnackBar(content: Text('Added to Cart'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  print(Provider.of<AddProductToCart>(context, listen: false)
                      .itemId[0]['quantity']);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 70, right: 20),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Add to cart",
                      style: TextStyle(fontSize: 20),
                    ),
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 188, 67, 1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
