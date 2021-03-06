import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var city;
  bool isLoading = true;
  var address;
  var usremail;
  var username;
  var profiledata;
  var phone;

  @override
  void initState() {
    super.initState();
    myinitstate();
  }

  myinitstate() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    usremail = sharedPreferences.getString("email");
    CollectionReference users = FirebaseFirestore.instance.collection(usremail);
    await users.get().then((QuerySnapshot querySnapshot) => {
          querySnapshot.docs.forEach((doc) {
            profiledata = doc.data();
          })
        });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: isLoading
                  ? Container(
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Loading...",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    )
                  : Container(
                      child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue[600],
                                borderRadius: BorderRadius.circular(18)),
                            height: MediaQuery.of(context).size.height * 0.69,
                            width: MediaQuery.of(context).size.width * 0.95,
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Your Profile",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 20.0,
                                    bottom: 10.0,
                                    left: 25.0,
                                    right: 25.0),
                                child: TextField(
                                  // onChanged: (val) {
                                  //   username = val;
                                  // },

                                  readOnly: true,
                                  // readOnly: widget.cName[1] == null ? false : true,
                                  // cursorColor: Colors.white,
                                  // keyboardType: TextInputType.emailAddress,
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
                                    hintText: profiledata["Name"],
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
                                    top: 10.0,
                                    bottom: 10.0,
                                    left: 25.0,
                                    right: 25.0),
                                child: TextField(
                                  readOnly: true,
                                  // cursorColor: Colors.white,
                                  // keyboardType: TextInputType.emailAddress,
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
                                    hintText: profiledata["Email"],
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
                                    top: 10.0,
                                    bottom: 10.0,
                                    left: 25.0,
                                    right: 25.0),
                                child: TextField(
                                  readOnly: true,
                                  // onChanged: (val) {
                                  //   phone = val;
                                  // },
                                  // cursorColor: Colors.white,
                                  // keyboardType: TextInputType.emailAddress,
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
                                    hintText: profiledata["Contact Number"],
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "WorkSansSemiBold",
                                        fontSize: 17.0),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 10.0,
                                    left: 25.0,
                                    right: 25.0),
                                child: TextField(
                                  readOnly: true,
                                  // onChanged: (val) {
                                  //   address = val;
                                  // },
                                  cursorColor: Colors.white,
                                  maxLines: 2,
                                  // keyboardType: TextInputType.emailAddress,
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
                                    hintText: profiledata["Address"],
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "WorkSansSemiBold",
                                        fontSize: 17.0),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 10.0,
                                    left: 25.0,
                                    right: 25.0),
                                child: TextField(
                                  readOnly: true,
                                  // onChanged: (val) {
                                  //   city = val;
                                  // },
                                  // cursorColor: Colors.white,
                                  // keyboardType: TextInputType.emailAddress,
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
                                    hintText: profiledata["City"],
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "WorkSansSemiBold",
                                        fontSize: 17.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )))),
    );
  }
}
