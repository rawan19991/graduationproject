import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  static const String id = 'OrderDetails';

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
   Stream<QuerySnapshot> usersStream;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        // usersStream = FirebaseFirestore.instance
        //     .collection('order')
        //     .where('email', isEqualTo: email)
        //     .
        //     .collection('OrderDetails')
        //     .snapshots();
       //  usersStream.listen((snapshot) {
       //    snapshot.docs.forEach((doc) {
       // print(doc.id.isEmpty)  ;
          });
        });
      }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: usersStream,
            builder: (context, snapshot) {
              
              if (!snapshot.hasData) {
                return Container();
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              print(snapshot.hasData);

              print(snapshot.data.docs.length);

              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    print(snapshot.data.docs.length);
                    print(snapshot.data.docs[index]['locationProduct']);
                    return Text(snapshot.data.docs[index]['locationProduct']);
                  });
            }));
  }
}
