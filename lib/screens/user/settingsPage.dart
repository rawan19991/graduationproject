
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../auth/sign_login.dart';
import 'homePage.dart';
import 'profilPage.dart';

class SettingsPage extends StatelessWidget {
  
  static const String id = 'SettingsPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "Settings",
              style: TextStyle(color: Colors.black.withOpacity(.8)),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            leading: InkWell(
              onTap: () {
                Navigator.pushNamed(context, HomePage.id);
              },
              child: Icon(
                Icons.arrow_back_ios_sharp,
                color: Colors.black,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, SignOrLogin.id);
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
              )
            ]),
        body: ListView(
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, ProfilePage.id);
              },
              child: buildListTile(Icons.account_circle, 'Account & Profile',
                  Icons.arrow_forward_ios_outlined),
            ),
            Divider(),
            buildListTile(
                Icons.settings, 'General', Icons.arrow_forward_ios_outlined),
            Divider(),
            buildListTile(Icons.workspaces_outline, 'Appearance',
                Icons.arrow_forward_ios_outlined),
            Divider(),
            buildListTile(
                Icons.call, 'Calling', Icons.arrow_forward_ios_outlined),
            Divider(),
            buildListTile(
                Icons.message, 'Messaging', Icons.arrow_forward_ios_outlined),
            Divider(),
            buildListTile(Icons.notifications_none, 'Notifications',
                Icons.arrow_forward_ios_outlined),
            Divider(),
            buildListTile(Icons.contact_mail, 'Contacts',
                Icons.arrow_forward_ios_outlined),
            Divider(),
            buildListTile(Icons.help_outline, 'Help & Feedback ',
                Icons.arrow_forward_ios_outlined),
            Divider(),
            buildListTile(
                Icons.logout, 'Logout', Icons.arrow_forward_ios_outlined),
            Divider(),
          ],
        ));
  }

  ListTile buildListTile(IconData leading, String text, IconData trailing) {
    return ListTile(
      leading: Icon(
        leading,
        size: 28,
      ),
      title: Text(
        text,
        style: TextStyle(fontSize: 17),
      ),
      trailing: Icon(
        trailing,
        color: Colors.black.withOpacity(.5),
      ),
    );
  }
}
