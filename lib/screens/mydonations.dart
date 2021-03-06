import 'package:charitable/screens/postdetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDonations extends StatefulWidget {
  @override
  _MyDonationsState createState() => _MyDonationsState();
}

class _MyDonationsState extends State<MyDonations> {
  var emailvalue;
  bool isLoaded = false;
  SharedPreferences sharedPreferences;
  CollectionReference users;
  @override
  void initState() {
    myinitstate();
    formatTimestamp();
    super.initState();
  }

  formatTimestamp() {
    var format = new DateTime.now();
    print(format);
  }

  myinitstate() async {
    sharedPreferences = await SharedPreferences.getInstance();
    emailvalue = sharedPreferences.getString("email");
    users = FirebaseFirestore.instance.collection(emailvalue);
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: isLoaded
                ? stream(context)
                : SafeArea(
                    child: Center(
                      child: Container(
                        color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Loading...",
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )));
  }

  Widget stream(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('posts');

    return StreamBuilder<QuerySnapshot>(
      stream: users.where("creator", isEqualTo: emailvalue).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }
        if (snapshot.hasData == true) {
          if (snapshot.data.size == 0) {
            return Center(
              child: Container(
                padding: EdgeInsets.all(23),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue[500],
                ),
                // color: Colors.grey[350],
                width: MediaQuery.of(context).size.width * 0.92,
                height: MediaQuery.of(context).size.width * 0.27,
                child: Text(
                  "No Donations Yet . Tap + Icon to Donate .",
                  style: GoogleFonts.questrial(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SafeArea(
            child: Center(
              child: Container(
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Loading...",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
            ),
          );
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return Center(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(width: 0.9, color: Colors.blue[600]),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue[500],
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(10)),
                          ),
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Posted on " +
                                  DateTime.parse(document
                                          .data()["timestamp"]
                                          .toDate()
                                          .toString())
                                      .toString()
                                      .substring(0, 10),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Divider(
                          height: 0,
                          thickness: 0.6,
                          color: Colors.black,
                        ),
                        ListTile(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PostDetails(
                                        documentid: document.id,
                                      ))),
                          isThreeLine: true,
                          tileColor: Colors.white24,
                          dense: true,
                          title: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 8, bottom: 8),
                            child: Text(
                              document.data()["title"],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          leading: Icon(
                            FontAwesomeIcons.laptop,
                            size: 28,
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(right: 8, bottom: 8),
                            child: Text(
                              document.data()["Address"],
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue[500],
                                    borderRadius: BorderRadius.circular(9)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    document.data()["Category"],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ]),
                    ),
                  )),
            );
          }).toList(),
        );
      },
    );
  }
}
