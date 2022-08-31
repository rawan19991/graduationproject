import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    ),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.red,
  ));
}
