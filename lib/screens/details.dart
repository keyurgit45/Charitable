import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'extension.dart';

// ignore: must_be_immutable
class Details extends StatefulWidget {
  String title;
  Details({this.title});
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String username;
  String useremail;
  String phone;
  String titleofpost;
  String pickupfrom;
  String type;
  String typename;
  String quantity;
  String description;
  bool ph1 = false;
  bool ph2 = false;
  bool ph3 = false;
  Map photourls = {};
  onPressed() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    useremail = sharedPref.getString("email");
    // username = sharedPref.getString("name");
    // phone = sharedPref.getString("contact");
    CollectionReference user = FirebaseFirestore.instance.collection("posts");

    await user.get().then((QuerySnapshot querySnapshot) => {
          querySnapshot.docs.forEach((doc) {
            username = doc.data()["Name"];
            phone = doc.data()["Contact Number"];
          })
        });

    if (titleofpost != null &&
        pickupfrom != null &&
        description != null &&
        ph1) {
      CollectionReference posts =
          FirebaseFirestore.instance.collection("posts");
      print("1");
      await posts.add({
        'Name': username.inCaps,
        'Email': useremail,
        'Contact Number': phone,
        'Address': pickupfrom,
        'creator': useremail,
        'Category': widget.title,
        'title': titleofpost.inCaps,
        'Type': type.inCaps,
        'Typename': widget.title == "Blood" ? "No Name" : typename,
        "Quantity": quantity,
        'Description': description.inCaps,
        "timestamp": FieldValue.serverTimestamp(),
        "Photourls": photourls
      }).then((value) {
        showInSnackBar("Post Added");
        Navigator.of(context).pop();
      }).catchError((error) => print("Failed to add user: $error"));
    } else {
      showInSnackBar("Required Fields should not be empty");
    }
    print("object");
  }

  uploadPhoto(int no) async {
    print("object");
    FirebaseStorage storage = FirebaseStorage.instance;

    File image;
    try {
      //Get the file from the image picker and store it
      // ignore: deprecated_member_use
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
      // ignore: unused_catch_clause
    } on PlatformException catch (e) {
      //PlatformException is thrown with code : this happen when user back with don't
      //selected image or not approve permission so stop method here
      // check e.code to know what type is happen
      print(e);
      return;
    }

    //Create a reference to the location you want to upload to in firebase
    var reference = storage.ref().child("$useremail/image$no");
    showInSnackBar("Uploading....");
    //Upload the file to firebase
    var uploadTask = reference.putFile(image);

    var taskSnapshot =
        await uploadTask.whenComplete(() => showInSnackBar("Uploading Done!"));

    // Waits till the file is uploaded then stores the download url
    String url = await taskSnapshot.ref.getDownloadURL();
    photourls["$no"] = url;
    switch (no) {
      case 1:
        {
          ph1 = true;
        }
        break;

      case 2:
        {
          ph2 = true;
        }
        break;

      case 3:
        {
          ph3 = true;
        }
        break;
    }
    print(url);
    setState(() {
      print("$ph1 , $ph2 , $ph3");
      print(photourls);
    });
  }

  void showInSnackBar(String value) {
    // ignore: deprecated_member_use
    _scaffoldKey.currentState
        // ignore: deprecated_member_use
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Fill Details"),
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 12.0, bottom: 10.0, left: 15.0, right: 15.0),
                  child: TextField(
                    textCapitalization: TextCapitalization.sentences,
                    onChanged: (val) {
                      titleofpost = val;
                    },

                    // readOnly: widget.cName[1] == null ? false : true,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        fontSize: 16.0,
                        color: Colors.black),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(9.0),
                        borderSide: new BorderSide(),
                      ),
                      hintText: "Title of the Post *",
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 15.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 12.0, bottom: 10.0, left: 15.0, right: 15.0),
                  child: TextField(
                    onChanged: (val) {
                      pickupfrom = val;
                    },
                    textCapitalization: TextCapitalization.sentences,
                    // readOnly: widget.cName[1] == null ? false : true,
                    cursorColor: Colors.blue,
                    keyboardType: TextInputType.streetAddress,
                    style: TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        fontSize: 16.0,
                        color: Colors.black),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(9.0),
                        borderSide: new BorderSide(),
                      ),
                      hintText: "Pickup From (Address) *",
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 15.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 12.0, bottom: 10.0, left: 15.0, right: 15.0),
                  child: TextField(
                    onChanged: (val) {
                      type = val;
                    },

                    // readOnly: widget.cName[1] == null ? false : true,
                    cursorColor: Colors.blue,
                    style: TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        fontSize: 16.0,
                        color: Colors.black),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(9.0),
                        borderSide: new BorderSide(),
                      ),
                      hintText: widget.title == "Blood"
                          ? "${widget.title} group * "
                          : "${widget.title} type ",
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 15.0),
                    ),
                  ),
                ),
                widget.title == "Blood"
                    ? SizedBox(
                        height: 1,
                      )
                    : Padding(
                        padding: EdgeInsets.only(
                            top: 12.0, bottom: 10.0, left: 15.0, right: 15.0),
                        child: TextField(
                          onChanged: (val) {
                            typename = val;
                          },

                          // readOnly: widget.cName[1] == null ? false : true,
                          cursorColor: Colors.blue,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(9.0),
                              borderSide: new BorderSide(),
                            ),
                            hintText: "${widget.title} name *",
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 15.0),
                          ),
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 12.0, bottom: 10.0, left: 15.0, right: 15.0),
                  child: TextField(
                    onChanged: (val) {
                      quantity = val;
                    },

                    // readOnly: widget.cName[1] == null ? false : true,
                    cursorColor: Colors.blue,
                    style: TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        fontSize: 16.0,
                        color: Colors.black),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(9.0),
                        borderSide: new BorderSide(),
                      ),
                      hintText: "Quantity",
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 15.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 12.0, bottom: 10.0, left: 15.0, right: 15.0),
                  child: TextField(
                    textCapitalization: TextCapitalization.sentences,
                    onChanged: (val) {
                      description = val;
                    },
                    maxLines: 6,
                    // readOnly: widget.cName[1] == null ? false : true,
                    cursorColor: Colors.blue,
                    style: TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        fontSize: 16.0,
                        color: Colors.black),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(9.0),
                        borderSide: new BorderSide(),
                      ),
                      hintText: "Description *",
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 15.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.7),
                        borderRadius: BorderRadius.circular(9)),
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.93,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Upload Images (at least 3) *",
                            style: TextStyle(fontSize: 21),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  uploadPhoto(1);
                                },
                                child: Icon(
                                  Icons.upload_file,
                                  color: ph1 ? Colors.blue : Colors.black,
                                  size: 35,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  uploadPhoto(2);
                                },
                                child: Icon(
                                  Icons.upload_file,
                                  color: ph2 ? Colors.blue : Colors.black,
                                  size: 35,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  uploadPhoto(3);
                                },
                                child: Icon(
                                  Icons.upload_file,
                                  color: ph3 ? Colors.blue : Colors.black,
                                  size: 35,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CupertinoButton(
                  child: Text("Post"),
                  onPressed: onPressed,
                  color: Colors.blue[500],
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
