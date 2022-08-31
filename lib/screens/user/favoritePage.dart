import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/filter_category.dart';
import 'homePage.dart';
import 'methodes/flter_category_user.dart';

class FavoritePage extends StatefulWidget {
  static const String id = 'FavoritePage';

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  Stream<QuerySnapshot> querySnapshot;
  @override
  void initState() {
    
    super.initState();
    if (Provider.of<FilterCategoryItem>(context, listen: false).categoryUser ==
        null) {
      querySnapshot = FirebaseFirestore.instance
          .collection('product')
          .where('Favorit', isEqualTo: true)
          .snapshots();
    } else {
      querySnapshot = FirebaseFirestore.instance
          .collection('product')
          .where('Favorit', isEqualTo: true)
          .where('category',
              isEqualTo: Provider.of<FilterCategoryItem>(context, listen: false)
                  .categoryUser)
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(.9),
        resizeToAvoidBottomInset: true,
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
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: (){
                  Navigator.pushNamed(context, FilterCategoryUser.id);

                },
                child: Icon(
                  Icons.filter_list_sharp,
                  color: Colors.black.withOpacity(.5),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(

            children: [
              Center(
                child: Text(
                  "My Favorite",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Overlock',
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(.6)),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: querySnapshot,
                  builder: (context, snapshot) {

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.data.docs.length==0) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 250,),
                          Center(child: Text("No Favorite Category",style: TextStyle(fontSize: 20,color: Colors.black.withOpacity(.5)),)),
                        ],
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                height: 120,
                                width: double.infinity,
                                child: SingleChildScrollView(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(
                                          1.0,
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: Container(
                                            child: Align(
                                              child: Image.asset(
                                                snapshot.data.docs[index]
                                                    ['image'],
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .3,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, right: 8.0, bottom: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data.docs[index]['name'],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: 'Overlock',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            buildTextDesc(snapshot, index),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15, left: 1),
                                              child: Text(
                                                ' \$${snapshot.data.docs[index]['price']}.00',
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          FirebaseFirestore.instance
                                              .collection('product')
                                              .doc(snapshot.data.docs[index].id)
                                              .update({'Favorit': false})
                                              .then((value) =>
                                                  print("Favorit Updated"))
                                              .catchError((error) => print(
                                                  "Failed to update Favorit: $error"));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.delete,
                                            size: 27,
                                            color: Colors.black.withOpacity(.7),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  }),
            ],
          ),
        ));
  }

  Text buildTextDesc(AsyncSnapshot<QuerySnapshot> snapshot, int index) {
    return Text(
      snapshot.data.docs[index]['description'].length > 17
          ? snapshot.data.docs[index]['description'].substring(0, 17) + '...'
          : snapshot.data.docs[index]['description'],
      style: TextStyle(
        color: Colors.black.withOpacity(.5),
        fontSize: 15,
      ),
    );
  }
}
