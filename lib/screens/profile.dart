// import 'package:charitable/style/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
//! intro profile page

class ProfilePage extends StatefulWidget {
  // final List<String> cName;
  // ProfilePage({Key key, this.cName}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _phone;
  String username;
  String useremail;
  String _address;

  String _city;

  bool isIdUploaded;

  onPressed() async {
    print("clicked");
    if (_phone != null && _address != null && username != null) {
      SharedPreferences sharedPref = await SharedPreferences.getInstance();

      sharedPref.setString("contact", _phone);
      sharedPref.setString("name", username);
      // print(sharedPref.getString("email"));
      CollectionReference users =
          FirebaseFirestore.instance.collection(useremail);
      users.add({
        'Name': username,
        'Email': useremail,
        'Contact Number': _phone,
        'Address': _address,
        'City': _city,
        'isIdUploaded': false
      }).then((value) {
        print("User Added");
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
      }).catchError((error) => print("Failed to add user: $error"));
    } else {
      showInSnackBar("Complete your profile First!");
    }
  }

  getnameandemail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      useremail = sharedPreferences.getString("email");
      username = sharedPreferences.getString("name");
    });
  }

  void showInSnackBar(String value) {
    // ignore: deprecated_member_use
    _scaffoldKey.currentState
        // ignore: deprecated_member_use
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  void initState() {
    getnameandemail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
          child: Center(
              child: Container(
                  child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue[500],
                  borderRadius: BorderRadius.circular(18)),
              height: MediaQuery.of(context).size.height * 0.85,
              width: MediaQuery.of(context).size.width * 0.97,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Complete Your Profile",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 20.0, bottom: 10.0, left: 25.0, right: 25.0),
                  child: TextField(
                    onChanged: (val) {
                      username = val;
                    },
                    readOnly: username == "Null" ? false : true,
                    // readOnly: widget.cName[1] == null ? false : true,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        fontSize: 16.0,
                        color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        FontAwesomeIcons.user,
                        color: Colors.white,
                        size: 22.0,
                      ),
                      hintText: username == "Null" ? "Full Name*" : username,
                      // widget.cName[1] == null ? "Null" : widget.cName[1],
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 17.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 25.0, right: 25.0),
                  child: TextField(
                    // readOnly: widget.cName[0] == null ? false : true,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        fontSize: 16.0,
                        color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        FontAwesomeIcons.envelope,
                        color: Colors.white,
                        size: 22.0,
                      ),
                      hintText: useremail,
                      // widget.cName[0] == null ? "Null" : widget.cName[0],
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 17.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 25.0, right: 25.0),
                  child: TextField(
                    onChanged: (val) {
                      _phone = val;
                    },
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        fontSize: 16.0,
                        color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.phone,
                        color: Colors.white,
                        size: 25.0,
                      ),
                      hintText: "Contact Number*",
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 17.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 25.0, right: 25.0),
                  child: TextField(
                    onChanged: (val) {
                      _address = val;
                    },
                    cursorColor: Colors.white,
                    maxLines: 2,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        fontSize: 16.0,
                        color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        FontAwesomeIcons.addressCard,
                        color: Colors.white,
                        size: 22.0,
                      ),
                      hintText: "Address*",
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 17.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 25.0, right: 25.0),
                  child: TextField(
                    onChanged: (val) {
                      _city = val;
                    },
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        fontSize: 16.0,
                        color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        FontAwesomeIcons.city,
                        color: Colors.white,
                        size: 22.0,
                      ),
                      hintText: "City",
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 17.0),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 10),
                      child: Icon(
                        Icons.upload_file,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                      child: InkWell(
                        onTap: () {
                          showInSnackBar(
                              "Not Available as this app is for demo purpose only");
                        },
                        child: Text(
                          "Upload Id Proof \n(Adhar Card/Pan Card/Voter Id)",
                          softWrap: true,
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: MaterialButton(
                      color: Colors.white,
                      // highlightColor: Colors.transparent,
                      splashColor: Colors.white,
                      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Next",
                          style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 25.0,
                              fontFamily: "WorkSansBold"),
                        ),
                      ),
                      onPressed: onPressed),
                ),
              ],
            ),
          ),
        ],
      )))),
    );
  }
}
