import 'package:charitable/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginScreens/login_page.dart';

// import '../Login/Signup/login_helper.dart';
// import '../Login/Signup/login_page.dart';

void main() async {
  runApp(MyApp());

  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void initState() {
    super.initState();
    // initfirebase();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
      // (Route<dynamic> route) => false);
      // print('pushing login page')
    } else if (sharedPreferences.getString("token") == "value") {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => Home()));
    }
    print(sharedPreferences.getString("token"));
    // sleep(Duration(seconds: 1));

    // sharedPreferences.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            "We Rise By Lifting Others",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 50),
          ),
        )),
      ),
    );
  }
}
