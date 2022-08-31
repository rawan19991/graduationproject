import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduationproject/screens/admin/show_product.dart';
import 'package:graduationproject/screens/admin/view_orders.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../auth/sign_login.dart';
import '../../provider/imageProfil.dart';
import '../../provider/modalProgressHUD.dart';
import 'add_product.dart';
import 'your_profile.dart';

class AdminPanel extends StatelessWidget {
  
  static const String id = 'AdminPanel';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
      inAsyncCall: Provider.of<ProgressProvider>(
        context,
      ).inAsyncCall,
      child: Center(
          child: Column(
        children: [
          SizedBox(
            height: 130,
          ),
          Container(
            padding: EdgeInsets.only(top: 10, left: 10),
            decoration: BoxDecoration(
              border: Border(
                  left: BorderSide(
                    //                   <--- left side
                    color: Colors.black,
                    width: 3.0,
                  ),
                  top: BorderSide(
                    //                    <--- top side
                    color: Colors.black,
                    width: 3.0,
                  )),
            ),
            child: Text("Admin Panel",
                style: TextStyle(fontFamily: 'Overlock', fontSize: 50)),
          ),
          SizedBox(
            height: 100,
          ),
          ElevatedButtonTheme(
            data: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(255, 193, 47, 1.0) ,
                minimumSize: Size(150, 50),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AddProduct.id);
                  },
                  child: Text(
                    'add product'.toUpperCase(),
                    style: TextStyle(fontFamily: 'CrimsonText', fontSize: 25),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ShowProduct.id);
                  },
                  child: Text(
                    'Edit product'.toUpperCase(),
                    style: TextStyle(fontFamily: 'CrimsonText', fontSize: 25),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {

                    Navigator.pushNamed(context, ViewOrder.id);

                  }
                  ,
                  child: Text(
                    'View orders'.toUpperCase(),
                    style: TextStyle(fontFamily: 'CrimsonText', fontSize: 25),
                  ),
                ),
                SizedBox(height: 20),

                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushNamed(context, SignOrLogin.id);
                  },
                  child: Text(
                    'log out'.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'CrimsonText',
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    ));
  }
}
