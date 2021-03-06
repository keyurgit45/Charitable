import 'package:charitable/LoginScreens/login_page.dart';
import 'package:charitable/screens/homepage.dart';
import 'package:charitable/screens/profilepage.dart';
import 'package:charitable/screens/NGO.dart';
import 'package:charitable/screens/selectCategory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mydonations.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Properties & Variables needed
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var emailvalue;
  SharedPreferences sharedPreferences;
  CollectionReference users;
  var photoUrl;
  var imgaddr =
      "https://www.pinclipart.com/picdir/big/164-1640714_user-symbol-interface-contact-phone-set-add-sign.png";
  var name;
  @override
  void initState() {
    myinitstate();
    super.initState();
  }

  void showInSnackBar(String value) {
    // ignore: deprecated_member_use
    _scaffoldKey.currentState
        // ignore: deprecated_member_use
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  myinitstate() async {
    sharedPreferences = await SharedPreferences.getInstance();
    emailvalue = sharedPreferences.getString("email");
    users = FirebaseFirestore.instance.collection(emailvalue);
    photoUrl = FirebaseAuth.instance.currentUser.photoURL;
    name = FirebaseAuth.instance.currentUser.displayName;
    print(name);
    setState(() {});
  }

  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    HomePage(),
    MyDonations(),
    Profile(),
    NGO(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomePage(); // Our first view in viewport

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        elevation: 0.0,
        centerTitle: true,
        toolbarHeight: 60,
        title: Text("CharitAble", style: TextStyle(fontSize: 32)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(11.0),
            child: InkWell(
              child: Icon(Icons.logout),
              onTap: () async {
                print(emailvalue);
                // await users.get().then((snapshot) {
                //   for (DocumentSnapshot ds in snapshot.docs) {
                //     ds.reference.delete();
                //   }
                // });
                sharedPreferences.clear();
                // ignore: deprecated_member_use
                sharedPreferences.commit();
                // ignore: deprecated_member_use
                // await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image(
                        height: 100,
                        width: 100,
                        image: NetworkImage(
                          photoUrl == null ? imgaddr : photoUrl,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        name == null ? "UserName" : name,
                        style: TextStyle(color: Colors.white, fontSize: 21),
                      ),
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () => showInSnackBar("Feature Not Unlocked Yet!"),
            ),
            ListTile(
              title: Text('Help and Support'),
              onTap: () => showInSnackBar("Feature Not Unlocked Yet!"),
            ),
          ],
        ),
      ),
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SelectCategory()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            HomePage(); // if user taps on this dashboard tab will be active
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.dashboard,
                          color: currentTab == 0 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Explore',
                          style: TextStyle(
                            color: currentTab == 0 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            MyDonations(); // if user taps on this dashboard tab will be active
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.chat,
                          color: currentTab == 1 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Donations',
                          style: TextStyle(
                            color: currentTab == 1 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              // Right Tab bar icons

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            Profile(); // if user taps on this dashboard tab will be active
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.dashboard,
                          color: currentTab == 2 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                            color: currentTab == 2 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            NGO(); // if user taps on this dashboard tab will be active
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.chat,
                          color: currentTab == 3 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          "NGO's",
                          style: TextStyle(
                            color: currentTab == 3 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
