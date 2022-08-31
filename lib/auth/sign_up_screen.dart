import 'package:cloud_firestore/cloud_firestore.dart';
import '../provider/invisible_icon.dart';
import '../provider/modalProgressHUD.dart';
import '../screens/admin/admin_panel.dart';
import '../screens/user/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../widget/facebook_login.dart';
import '../widget/google_login.dart';
import '../widget/showSnackBar.dart';
import '../widget/sign_up.dart';
import '../widget/textformfield_1.dart';
import 'log_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'SignUpScreen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final nameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text(
        "Success",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        textAlign: TextAlign.center,
      ),
      content: Text(
        "Do you want to login as admin or user ?",
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          child: Text("Admin"),
          onPressed: () async {
            if (emailController.text.toString().trim().contains("admin")) {
              Navigator.pushNamed(context, AdminPanel.id);
              Provider.of<ProgressProvider>(context, listen: false)
                  .isLoding(false);
            } else {
              showSnackBar(context, 'There is no admin with this data.');
            }
          },
        ),
        TextButton(
            child: Text("User"),
            onPressed: () async {
              Navigator.pushNamed(context, HomePage.id);
              Provider.of<ProgressProvider>(context, listen: false)
                  .isLoding(false);
            }),
      ],
    );

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ProgressProvider>(
          context,
        ).inAsyncCall,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 70,
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
                  fontSize: 24,
                  color: Colors.black.withOpacity(.7),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView(
                  children: [
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormFieldAll("Full name", nameController,
                                false, validatorName,prefixIcon:  Icons.person,),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormFieldAll("Email", emailController,
                                false, validatorEmail,prefixIcon:Icons.email),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormFieldAll(
                                "Password",
                                passwordController,

                                Provider.of<InvisibleIcon>(context).invisible,
                                validatorPassword,
                                ctx: context,
                                suffixIcon: true,prefixIcon:   Icons.lock,),
                            SizedBox(
                              height: 15,
                            ),
                            SignUp(() async {
                              if (_formKey.currentState.validate()) {
                                UserCredential response = await signUpFun(
                                    emailController,
                                    passwordController,
                                    context);
                                if (response != null) {
                                  addUser(nameController, emailController,
                                      passwordController);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alert;
                                    },
                                  );
                                }
                              }
                            }, "Sign Up", 320.0),
                            SizedBox(
                              height: 30,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don\'t have an acount? ",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(.4),
                                      fontSize: 15),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, LogInScreen.id);
                                  },
                                  child: Text(
                                    "Log in",
                                    style: TextStyle(
                                        color: Color.fromRGBO(255, 193, 47, 1.0)
                                            .withOpacity(.8),
                                        fontSize: 20),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding lineWidget({left, right}) {
    return Padding(
      padding: EdgeInsets.only(left: left, right: right),
      child: Container(
        height: 1.0,
        width: 140.0,
        color: Colors.black.withOpacity(.5),
      ),
    );
  }
}
