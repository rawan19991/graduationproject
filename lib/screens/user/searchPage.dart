import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../../model/product.dart';
import 'methodes/produt_details.dart';

class SearchPage extends StatefulWidget {
  static const String id = 'SearchPage';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  
  Stream<QuerySnapshot> querySnapshot;
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              onChanged: (val) {
                setState(() {
                  text = val;
                });
              },
              decoration: InputDecoration(
                  prefixIcon: IconButton(
                    color: Colors.black,
                    icon: Icon(Icons.arrow_back),
                    iconSize: 20.0,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  contentPadding: EdgeInsets.only(left: 25.0),
                  hintText: 'Search by name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0))),
            ),
          ),
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: text == ''
                      ? querySnapshot = FirebaseFirestore.instance
                          .collection('product')
                          .snapshots()
                      : querySnapshot = FirebaseFirestore.instance
                          .collection('product')
                          .where(
                            'search',
                            arrayContains: text,
                          )
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData) {
                      return Center(
                          child: Center(
                              child:
                                  Text("There is no product with this name")));
                    }
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                // ignore: missing_required_param
                                Product product = Product(
                                  name: snapshot.data.docs[index]['name'],
                                  category: snapshot.data.docs[index]['category'],
                                  description: snapshot.data.docs[index]['description'],
                                  image: snapshot.data.docs[index]['image'],
                                  price: snapshot.data.docs[index]['price'],
                                  id: snapshot.data.docs[index].id,
                                  favorite: snapshot.data.docs[index]['Favorit'],
                                );
                                Navigator.pushNamed(context, ProductDetails.id,
                                    arguments: product);
                              },
                              child: ListTile(
                                title: Text(snapshot.data.docs[index]['name']),
                                subtitle: Text(
                                  snapshot.data.docs[index]['description'],
                                  maxLines: 1,
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey.withOpacity(.5),
                                  child: Image.asset(
                                    snapshot.data.docs[index]['image'],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                trailing: Icon(Icons.keyboard_arrow_right),
                              ),
                            ),
                          );
                        });
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
