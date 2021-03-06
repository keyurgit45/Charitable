import 'package:charitable/screens/images.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PostDetails extends StatefulWidget {
  var documentid;

  PostDetails({this.documentid});
  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  Map userdata = {
    "Name": "-",
    "Address": "-",
    "Contact Number": "-",
    "title": "-",
    "Type": "-",
    "Category": "-",
    "Description": "-",
    "Quantity": "-",
    "Photourls": {}
  };

  onPressed() async {
    CollectionReference user = FirebaseFirestore.instance.collection("posts");

    var getdata = await user.doc(widget.documentid).get();
    userdata = getdata.data();
    setState(() {
      print(userdata);
    });
  }

  @override
  void initState() {
    onPressed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Post Details"),
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Name : ",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 19)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 12.0, bottom: 10.0, left: 15.0, right: 15.0),
                  child: TextField(
                    readOnly: true,
                    textCapitalization: TextCapitalization.sentences,
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
                      hintText: userdata["Name"],
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 15.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Address : ",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 19)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 12.0, bottom: 10.0, left: 15.0, right: 15.0),
                  child: TextField(
                    readOnly: true,
                    maxLines: 4,
                    minLines: 2,
                    textCapitalization: TextCapitalization.sentences,
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
                      hintText: userdata["Address"],
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 15.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Contact Number : ",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 19)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 12.0, bottom: 10.0, left: 15.0, right: 15.0),
                  child: TextField(
                    readOnly: true,
                    textCapitalization: TextCapitalization.sentences,
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
                      hintText: userdata["Contact Number"],
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 15.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Title : ",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 19)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 12.0, bottom: 10.0, left: 15.0, right: 15.0),
                  child: TextField(
                    readOnly: true,
                    textCapitalization: TextCapitalization.sentences,
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
                      hintText: userdata["title"],
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 15.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Type : ",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 19)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 12.0, bottom: 10.0, left: 15.0, right: 15.0),
                  child: TextField(
                    readOnly: true,
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
                      hintText: userdata["Type"],
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 15.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Category : ",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 19)),
                    ],
                  ),
                ),
                widget.documentid == "Blood"
                    ? SizedBox(
                        height: 1,
                      )
                    : Padding(
                        padding: EdgeInsets.only(
                            top: 12.0, bottom: 10.0, left: 15.0, right: 15.0),
                        child: TextField(
                          readOnly: true,
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
                            hintText: userdata["Category"],
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 15.0),
                          ),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Quantity : ",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 19)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 12.0, bottom: 10.0, left: 15.0, right: 15.0),
                  child: TextField(
                    readOnly: true,
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
                      hintText: userdata["Quantity"],
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 15.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Description : ",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 19)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 12.0, bottom: 10.0, left: 15.0, right: 15.0),
                  child: TextField(
                    readOnly: true,
                    minLines: 3,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: 6,
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
                      hintText: userdata["Description"],
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
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.93,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => UploadedImages(
                                      photourls: userdata["Photourls"]))),
                          child: Text(
                            " Images (Click to  View) ",
                            style: TextStyle(fontSize: 21),
                          ),
                        ),
                        Icon(
                          Icons.image,
                          size: 35,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
