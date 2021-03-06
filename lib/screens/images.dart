import 'package:flutter/material.dart';

class UploadedImages extends StatelessWidget {
  final photourls;

  const UploadedImages({Key key, this.photourls}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Uploaded Images"),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(width: 3)),
                      child: Image(
                          height: 300,
                          width: 300,
                          image: NetworkImage(photourls["1"].toString())),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(width: 3)),
                      child: Image(
                          height: 300,
                          width: 300,
                          image: NetworkImage(photourls["2"].toString())),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(width: 3)),
                      child: Image(
                          height: 300,
                          width: 300,
                          image: NetworkImage(photourls["3"].toString())),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
