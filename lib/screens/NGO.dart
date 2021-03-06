import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NGO extends StatelessWidget {
  List<String> ngonames = [
    "Bhagini Niveditha Pratisthan",
    "Janaseva Foundation",
    "Malhar Janseva Foundation",
    "Umed Pariwar",
    "Aadhar Pratishthan Pune",
    "Aasakta Kalamanch Pune",
    "Agriculture Graduates Association"
  ];

  List<String> ngotype = [
    "Education",
    "Education",
    "Education",
    "Differently Abled",
    "Aged/Elderly",
    "Art & Culture",
    "Education & Literacy"
  ];

  List<String> ngoaddress = [
    "Flat No 7 Bhupati Complex 985, Sadashiv Peth Pune 411030 Maharashtra",
    "Indulal Complex, 1st floor Above Rupee Bank L.B.S. Road, Navi Peth	",
    "Ashwamegh, 49/24, Telco Kapoor Hsg.Soc. Nigdi Pradhikaran Nigdi",
    "Shanti Complex,2nd Floor , 428B, New Mangalwar Peth Narpatgiri Chowk,Pune",
    "SR.No-48/A,Sainagari,Chandannagar,pune 411014",
    "m7/336, snigdha society, laxminagar, parvati,",
    "Ganesh 2 flat 3 Near vishweshwar temple Bijalinagar Chinchwad pune 411033"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1.1),
                  borderRadius: BorderRadius.circular(7)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      margin: EdgeInsets.only(left: 7, right: 7),
                      child: Text(
                        ngonames[index],
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      margin: EdgeInsets.only(left: 7, right: 7),
                      child: Text(
                        ngotype[index],
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      margin: EdgeInsets.only(left: 7, right: 7),
                      child: Text(
                        ngoaddress[index],
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
