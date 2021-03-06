import 'package:charitable/screens/details.dart';
import 'package:flutter/material.dart';

class SelectCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Select Category"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "What Would you like to Donate ?",
                  style: TextStyle(fontSize: 21),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CategoryBlock(
                        context, "Houseold", "lib/assets/houseold.png"),
                    CategoryBlock(context, "Clothes", "lib/assets/clothes3.png")
                  ]),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CategoryBlock(context, "Blood", "lib/assets/blood.png"),
                    CategoryBlock(context, "Food", "lib/assets/dish.png")
                  ]),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CategoryBlock(context, "Others", "lib/assets/others.png"),
                    CategoryBlock(context, "Book", "lib/assets/book.png"),
                  ]),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget CategoryBlock(BuildContext context, String title, String img) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Details(title: title)));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            boxShadow: [
              BoxShadow(
                  color: Colors.white,
                  offset: Offset(1.0, 1.0), //(x,y)
                  blurRadius: 2.0,
                  spreadRadius: 3),
            ],
            // border: Border.all(width: 0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 8, left: 8, right: 15),
                  child: Image.asset(
                    img,
                    color: title == "Blood"
                        ? null
                        : title == "Clothes"
                            ? null
                            : title == "Book"
                                ? null
                                : Colors.white,
                    height: 80,
                    width: 80,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ]),
          // color: Colors.green,
          height: 140,
          width: 140,
        ),
      ),
    );
  }
}
