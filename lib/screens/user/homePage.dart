import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduationproject/screens/user/searchPage.dart';
import 'package:graduationproject/screens/user/settingsPage.dart';

import 'package:provider/provider.dart';
import 'package:unicorndial/unicorndial.dart';
import '../../model/product.dart';
import '../../provider/counter_order.dart';
import 'cartPage.dart';
import 'favoritePage.dart';
import 'methodes/filtter_category.dart';
import 'package:flutter/material.dart';

import 'methodes/produt_details.dart';

// ignore: must_be_immutable
// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  static const String id = 'HomePage';
  int counter = 0;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  CollectionReference product =
  FirebaseFirestore.instance.collection('product');
  int current = 0;

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    final childButtons = List<UnicornButton>();

    childButtons.add(UnicornButton(
        currentButton: FloatingActionButton(
          heroTag: "train",
          backgroundColor: Colors.black,
          mini: true,
          child: Icon(Icons.favorite),
          onPressed: () {
            Navigator.pushNamed(context, FavoritePage.id);
          },
        )));

    childButtons.add(UnicornButton(
        currentButton: FloatingActionButton(
          heroTag: "airplane",
          backgroundColor: Colors.black,
          mini: true,
          child: Icon(Icons.search),
          onPressed: () {
            Navigator.pushNamed(context, SearchPage.id);
          },
        )));

    childButtons.add(UnicornButton(
        currentButton: FloatingActionButton(
          heroTag: "directions",
          backgroundColor: Colors.black,
          mini: true,
          child: Icon(Icons.settings),
          onPressed: () {
            Navigator.pushNamed(context, SettingsPage.id);
          },
        )));
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Boxed",
                style: TextStyle(
                    color: Colors.black, fontFamily: 'Overlock', fontSize: 25),
              ),
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, CartPage.id);
                  },
                  child: Icon(Icons.shopping_cart, color: Colors.black))
            ],
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          bottom: buildTabBar(),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FilterCategory(current),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting||snapshot == null) {
              return Center(child: CircularProgressIndicator());
            }
            return buildGridView(snapshot, context);
          },
        ),
        floatingActionButton: buildUnicornDialer(childButtons),
      ),
    );
  }

  UnicornDialer buildUnicornDialer(List<UnicornButton> childButtons) {
    return UnicornDialer(
        backgroundColor: Color.fromRGBO(255, 255, 255, .75),
        parentButtonBackground: Color.fromRGBO(255, 193, 47, 1.0),
        orientation: UnicornOrientation.VERTICAL,
        parentButton: Icon(Icons.menu),
        childButtons: childButtons);
  }

  GridView buildGridView(
      AsyncSnapshot<QuerySnapshot> snapshot, BuildContext context) {



    return GridView.builder(
        itemCount: snapshot.data.docs.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
          MediaQuery.of(context).orientation == Orientation.landscape
              ? 3
              : 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 4,
          childAspectRatio: (4 / 5),
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Provider.of<CounterOrder>(context, listen: false).counter = 1;

              Product product = Product(
                name: snapshot.data.docs[index]['name'],
                category: snapshot.data.docs[index]['category'],
                description: snapshot.data.docs[index]['description'],
                image: snapshot.data.docs[index]['image'],
                price: snapshot.data.docs[index]['price'],
                id: snapshot.data.docs[index].id,
                favorite: snapshot.data.docs[index]['Favorit'],
                quantity: null,
              );
              Navigator.pushNamed(context, ProductDetails.id,
                  arguments: product);
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: Colors.blueAccent, style: BorderStyle.none),
                  color: Colors.grey.shade100,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            print(snapshot.data.docs[index].id);

                            if (snapshot.data.docs[index]['Favorit'] == true) {
                              product
                                  .doc(snapshot.data.docs[index].id)
                                  .update({'Favorit': false}).then(
                                      (value) => print("User Updated"));
                            } else if (snapshot.data.docs[index]['Favorit'] ==
                                false) {
                              product
                                  .doc(snapshot.data.docs[index].id)
                                  .update({'Favorit': true}).then(
                                      (value) => print("User Updated"));
                            }
                          },
                          icon: snapshot.data.docs[index]['Favorit'] == true
                              ? Icon(
                            Icons.favorite,
                            size: 30,
                            color: Colors.red,
                          )
                              : Icon(
                            Icons.favorite_border,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Image.asset(
                        snapshot.data.docs[index]['image'],
                        height: 50,
                        width: 100,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(snapshot.data.docs[index]['name'],
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'CrimsonText')),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        snapshot.data.docs[index]['description'],
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black.withOpacity(.5)),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        '${snapshot.data.docs[index]['price']}\$',
                        style: TextStyle(
                            fontFamily: 'SourceCodePro',
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  TabBar buildTabBar() {
    return TabBar(
      isScrollable: true,
      indicatorColor: Color.fromRGBO(255, 193, 47, 1.0),
      indicatorWeight: 3,
      labelColor: Colors.black,
      labelStyle: TextStyle(
          fontSize: 18,
          fontFamily: 'SourceCodePro',
          fontWeight: FontWeight.bold),
      unselectedLabelStyle: TextStyle(fontSize: 15),
      onTap: (int index) {
        setState(() {
          current = index;
        });
      },
      tabs: [
        Tab(
          text: 'All Category',
        ),
        Tab(
          text: 'Electrical device',
        ),
        Tab(
          text: 'Kitchen equipment',
        ),
        Tab(
          text: 'kitchen accessorise',
        ),
        Tab(
          text: 'cleaning',
        ),
        Tab(
          text: 'cups',
        ),
      ],
    );
  }
}
