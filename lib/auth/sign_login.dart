

import 'package:flutter/material.dart';
import 'package:graduationproject/auth/sign_up_screen.dart';

import '../widget/log_in.dart';
import '../widget/sign_up.dart';
import 'log_in_screen.dart';

class SignOrLogin extends StatelessWidget {
  static const String id = 'SignOrLogin';

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    SignInScreen() {
      Navigator.pushNamed(context, LogInScreen.id);
    }

    // ignore: non_constant_identifier_names
    SigUpScreen() {
      Navigator.pushNamed(context, SignUpScreen.id);
    }

    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Image.asset(
                "images/icons/buyicon.png",
                fit: BoxFit.fill,
                height: 120,
                width: 120,
              ),
              Text(
                "BOXED",
                style: TextStyle(
                  fontFamily: 'Overlock',
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black.withOpacity(.7),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "For electrical and household \n appliance",
                style: TextStyle(
                    fontFamily: 'SourceCodePro',
                    fontSize: 15,
                    color: Colors.black.withOpacity(.5)),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 150,
              ),
              SignUp(SigUpScreen,"Sign Up",300.0),
              SizedBox(
                height: 15,
              ),
              LogIn(SignInScreen),
            ],
          ),
        ),
      ),
    );
  }
}
