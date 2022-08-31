// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduationproject/widget/showSnackBar.dart';
import 'package:provider/provider.dart';

import '../provider/modalProgressHUD.dart';

final CollectionReference users =
    FirebaseFirestore.instance.collection('users');

// ignore: non_constant_identifier_names
Container SignUp(Function onPressed, String text, width) {
  return Container(
    child: RaisedButton(
      color: Colors.white,
      elevation: 0,
      onPressed: onPressed,
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        width: width,
        height: 45,
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: new LinearGradient(
              colors: [
                Color.fromRGBO(250, 208, 113, 1.0),
                //Color.fromRGBO(20, 120, 244, 1),
                Color.fromRGBO(255, 193, 47, 1.0)
              ],
            )),
        padding: const EdgeInsets.only(top: 12.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

signUpFun(TextEditingController email, TextEditingController password,
    BuildContext context) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.text.toString().trim(),
      password: password.text.toString().trim(),
    );

    return userCredential;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      Provider.of<ProgressProvider>(context, listen: false).isLoding(false);
      showSnackBar(context, 'The password provided is too weak.');
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      Provider.of<ProgressProvider>(context, listen: false).isLoding(false);
      showSnackBar(context, 'The account already exists for that email.');
      print('The account already exists for that email.');
    }
  } catch (e) {
    Provider.of<ProgressProvider>(context, listen: false).isLoding(false);
    showSnackBar(context, '$e');

    print(e);
  }
}

Future<void> addUser(TextEditingController name, TextEditingController email,
    TextEditingController password) {
  return users
      .add({
        'name': name.text.toString().trim(),
        'email': email.text.toString().trim(),
        'password': password.text.toString().trim(),
        'imageUrl': null,
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}
