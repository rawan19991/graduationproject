// ignore_for_file: deprecated_member_use


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduationproject/widget/showSnackBar.dart';
import 'package:provider/provider.dart';

import '../provider/modalProgressHUD.dart';

// ignore: non_constant_identifier_names
Container LogIn(Function onPressed) {
  return Container(
    padding: const EdgeInsets.all(1.0),
    width: 300,
    height: 45,
    decoration: BoxDecoration(
        color: Colors.white,
        border:
            Border.all(color: Color.fromRGBO(255, 193, 47, 1.0).withOpacity(.8)),
        borderRadius: BorderRadius.circular(5)),
    child: RaisedButton(
      color: Colors.white,
      onPressed: onPressed,
      elevation: 0,
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Text(
        "Log in",
        style: TextStyle(fontSize: 20, color: Color.fromRGBO(255, 193, 47, 1.0)),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
signInFun(
    TextEditingController email, TextEditingController password,BuildContext context) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email:email.text.toString().trim() ,
        password: password.text.toString().trim()
    );
    return userCredential;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      Provider.of<ProgressProvider>(context, listen: false).isLoding(false);
      showSnackBar(context,'No user found for that email.');
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      Provider.of<ProgressProvider>(context, listen: false).isLoding(false);
      showSnackBar(context,'Wrong password provided for that user.');
      print('Wrong password provided for that user.');
    }
  }
}

