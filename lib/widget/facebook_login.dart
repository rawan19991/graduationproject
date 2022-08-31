// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Container FacebookLogin(Function onPressed) {
  return Container(
    child: RaisedButton(
      color: Colors.white,
      elevation: 0,
      onPressed: onPressed,
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        width: 320,
        height: 45,
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: new LinearGradient(
              colors: [
                Color.fromRGBO(74, 110, 168, 1),
                Color.fromRGBO(74, 110, 168, 1),
              ],
            )),
        child: Row(
          children: [
            Container(
              color:Color.fromRGBO(17, 90, 156, 1) ,
              height: double.infinity,
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5)),
                  child: Image.asset(
                    "images/icons/facebook.png",
                    fit: BoxFit.cover,
                    height: 45,
                  )),
              padding: const EdgeInsets.all(
                8,
              ),
              alignment: Alignment.center,
            ),
            SizedBox(
              width: 40,
            ),
            Text(
              "Log in with Facebook",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}

