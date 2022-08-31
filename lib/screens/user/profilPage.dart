// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProfilePage extends StatefulWidget {
  
  static const String id = 'ProfilePage';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var _image;

  Reference ref;

  var imageUrl;

  var imageFromFireBase;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser.email)
        .get()
        .then((event) {
      if (event.docs.isNotEmpty) {
        Map<String, dynamic> documentData = event.docs.single.data();
        setState(() {
          imageFromFireBase = documentData['imageUrl'];
        });
      }
    }).catchError((e) => print("error fetching data: $e"));
  }

  @override
  Widget build(BuildContext context) {
    print(imageFromFireBase);

    AlertDialog alert = AlertDialog(
      title: Text(
        "From where ?",
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
      actions: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black,
                backgroundColor: Colors.blue.withOpacity(.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Camera",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  Icon(Icons.camera_enhance),
                ],
              ),
              onPressed: () async =>
                  await getImage(true).then((value) => Navigator.pop(context)),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black,
                backgroundColor: Colors.blue.withOpacity(.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Studio",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  Icon(Icons.camera),
                ],
              ),
              onPressed: () async =>
                  await getImage(false).then((value) => Navigator.pop(context)),
            ),
          ),
        ),
      ],
    );
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 70),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                child: ClipOval(
                  child: Center(
                    child: imageFromFireBase.toString().contains("null")
                        ? Icon(
                            Icons.person,
                            color: Colors.grey.shade700,
                            size: 100,
                          )
                        : (_image != null
                            ? Image.file(
                                _image,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              )
                            : CachedNetworkImage(
                                imageUrl: imageFromFireBase,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    new CircularPercentIndicator(
                                  radius: 100.0,
                                  lineWidth: 8.0,
                                  percent: 1.0,
                                  animation: true,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  center: new Text("Loading ..."),
                                  progressColor: Colors.green[700],
                                ),
                                errorWidget: (context, url, error) =>
                                    new Icon(Icons.error),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width,
                              )),
                  ),
                ),
                radius: 50,
                backgroundColor: Colors.grey.shade300,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  },
                  child: Icon(
                    Icons.camera_alt,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          RaisedButton(
            onPressed: pickUploadProfilePic,
            child: Text("Upload Image"),
          ),
        ],
      ),
    );
  }

  Future getImage(bool isCamera) async {
    PickedFile image;
    if (isCamera) {
      image = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
      );
    } else {
      image = await ImagePicker().getImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
    }

    setState(() {
      _image = File(image.path);
      print(image.path);
    });
  }

  // ignore: non_constant_identifier_names
  void UploadImage() async {
    var docsId;
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("image1" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(_image);
    await uploadTask.then((res) {
      res.ref.getDownloadURL().then((fileUrl) {
        print(FirebaseAuth.instance.currentUser.email);
        FirebaseFirestore.instance
            .collection('users')
            .doc(docsId)
            .set({
              'imageUrl': "$fileUrl",
            })
            .then((value) => print("image Added"))
            .catchError((error) => print("Failed to add image: $error"));
      });
    });

  }
  String profilePicLink = "";
  void pickUploadProfilePic() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
    );

    Reference ref = FirebaseStorage.instance
        .ref().child("profilepic.jpg");

    await ref.putFile(File(image.path));

    ref.getDownloadURL().then((value) async {
      setState(() {
        profilePicLink = value;
      });
    });
  }

}
