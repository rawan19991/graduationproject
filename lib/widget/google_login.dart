// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Container GoogleLogin(Function onPressed) {
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
            border: Border.all(
              color: Colors.black.withOpacity(.06),
            ),
            borderRadius: BorderRadius.circular(5),
            gradient: new LinearGradient(
              colors: [
                Colors.white,
                Colors.white,
              ],
            )),
        child: Row(
          children: [
            Container(
              height: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.black.withOpacity(.06),
                  ),
                ),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5)),
                  child: Image.asset(
                    "images/icons/google.PNG",
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
              "Log in with Google",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black.withOpacity(.4),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
