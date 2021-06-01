import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:projectsalon/services/database.dart';
import 'package:url_launcher/url_launcher.dart';

// String salonName;
// void nameIs(String name) {
//   salonName = name;
// }

var serviceList = [
  {'title': 'Hair Cut', 'duration': 45, 'price': 500},
  {'title': 'Hair Treatment', 'duration': 60, 'price': 1000},
  {'title': 'Skin Care', 'duration': 90, 'price': 300},
  {'title': 'Waxing', 'duration': 30, 'price': 600},
];

class DetailScreen extends StatefulWidget {
  final String salonname;

  const DetailScreen({Key key, this.salonname}) : super(key: key);
  @override
  _DetailScreenState createState() => _DetailScreenState(salonname);
}

class _DetailScreenState extends State<DetailScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  DatabaseMethods databaseMethods1 = new DatabaseMethods();
  QuerySnapshot searchSnapshot;
  QuerySnapshot snap;

  DatabaseMethods databaseMethods10 = new DatabaseMethods();
  QuerySnapshot searchSnapshot10;

  QuerySnapshot doc1;

  String salonName1;
  String review;
  String haircut;
  String address;
  String directions;
  String dp;
  String cover;
  String rating;
  String blowdry;
  String bridal;
  String cleanup;
  String eyebrowthreading;
  String haircolouring;
  String hairspa;
  String keratin;
  String manicure;
  String nailart;
  String pedicure;
  String protein;
  String straightening;
  String waxing;

  bool isLoading = true;
  String salonname;
  _DetailScreenState(this.salonname);

  initSearch() async {
    await databaseMethods.getSalonBySalonname(salonname).then((val) {
      if (mounted) {
        setState(() {
          searchSnapshot = val;
        });
      }
    });
    salonName1 = searchSnapshot.docs[0].data()["name"];
    dp = searchSnapshot.docs[0].data()["dp"];
    cover = searchSnapshot.docs[0].data()["cover"];
    review = searchSnapshot.docs[0].data()["Review"];
    rating = searchSnapshot.docs[0].data()["Rating"];
    address = searchSnapshot.docs[0].data()["Address"];
    directions = searchSnapshot.docs[0].data()["directions"];
    haircut = searchSnapshot.docs[0].data()["Hair cut"];
    waxing = searchSnapshot.docs[0].data()["Waxing"];
    straightening = searchSnapshot.docs[0].data()["Straightening"];
    protein = searchSnapshot.docs[0].data()["Protein"];
    pedicure = searchSnapshot.docs[0].data()["Pedicure"];
    nailart = searchSnapshot.docs[0].data()["Nail art"];
    manicure = searchSnapshot.docs[0].data()["Manicure"];
    keratin = searchSnapshot.docs[0].data()["Keratin"];
    hairspa = searchSnapshot.docs[0].data()["Hair spa"];
    haircolouring = searchSnapshot.docs[0].data()["Hair colouring"];
    eyebrowthreading = searchSnapshot.docs[0].data()["Eyebrow threading"];
    cleanup = searchSnapshot.docs[0].data()["Cleanup"];
    bridal = searchSnapshot.docs[0].data()["Bridal makeover"];
    blowdry = searchSnapshot.docs[0].data()["Blowdry and setting"];

    if (this.mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    initSearch();
    return Scaffold(
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 3 + 20,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          // fit: StackFit.expand,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 3),
                                image: DecorationImage(
                                    alignment: Alignment.topCenter,
                                    image: NetworkImage(cover),
                                    fit: BoxFit.fill),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 20,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 3 - 30,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        // height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 100,
                              ),
                              Text(
                                address,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),

                              Text(
                                'SERVICE LIST',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),

                              // ServiceTile(serviceList[1]),
                              // ServiceTile(serviceList[2]),
                              // ServiceTile(serviceList[3]),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 3 - 120,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 3 - 20,
                              height:
                                  MediaQuery.of(context).size.height / 6 + 20,
                              decoration: BoxDecoration(
                                // color: sbgColor'],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                child: Positioned(
                                  top: 25,
                                  right: 21,
                                  child: Container(
                                    height: 225,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 3),
                                      image: DecorationImage(
                                          alignment: Alignment.topCenter,
                                          image: NetworkImage(dp),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 100,
                                ),
                                Text(
                                  salonName1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23,
                                      color: Colors.brown),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: "Directions",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.grey[900],
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        var url = '$directions';
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not lauch $url';
                                        }
                                      },
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      rating,
                                      style: TextStyle(
                                        color: Color(0xffFF8573),
                                      ),
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 16,
                                      color: Color(0xffFF8573),
                                    ),
                                    SizedBox(width: 5),
                                    SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: MediaQuery.of(context).size.height / 3 - 55,
                      child: MaterialButton(
                          onPressed: () {},
                          padding: EdgeInsets.all(10),
                          shape: CircleBorder(),
                          color: Colors.white,
                          child: Icon(
                            Icons.chat,
                          )),
                    ),
                    SizedBox(height: 500),
                    Positioned(
                      top: 500,
                      child: Container(
                        width: 400,
                        height: 280,
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ServiceTile(
                                title: 'Hair cut',
                                rate: haircut,
                              ),
                              ServiceTile(
                                title: 'Nail Art',
                                rate: nailart,
                              ),
                              ServiceTile(
                                title: 'Waxing',
                                rate: waxing,
                              ),
                              ServiceTile(
                                  title: 'Straightening', rate: straightening),
                              ServiceTile(
                                title: 'Protein',
                                rate: protein,
                              ),
                              ServiceTile(
                                title: 'Pedicure',
                                rate: pedicure,
                              ),
                              ServiceTile(
                                title: 'Manicure',
                                rate: manicure,
                              ),
                              ServiceTile(
                                title: 'Keratin',
                                rate: keratin,
                              ),
                              ServiceTile(
                                title: 'Hair spa',
                                rate: hairspa,
                              ),
                              ServiceTile(
                                title: 'Hair Colouring',
                                rate: haircolouring,
                              ),
                              ServiceTile(
                                title: 'Threading',
                                rate: eyebrowthreading,
                              ),
                              ServiceTile(
                                title: 'Cleanup',
                                rate: cleanup,
                              ),
                              ServiceTile(
                                title: 'Bridal',
                                rate: bridal,
                              ),
                              ServiceTile(
                                title: 'Blow Dry',
                                rate: blowdry,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 790,
                      child: Container(
                        width: 430,
                        height: 130,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.all(20),
                                width: MediaQuery.of(context).size.width,
                                color: Colors.black,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'REVIEW',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.yellow[300],
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      review,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

class ServiceTile extends StatelessWidget {
  final String title;
  final String rate;
  ServiceTile({this.title, this.rate});

  @override
  Widget build(BuildContext context) {
    if (rate != '' || rate != null) {
      return Container(
        margin: EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2 - 40,
                  child: Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.brown),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
            Text(
              rate,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            MaterialButton(
              onPressed: () {},
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Book',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    } else
      return Container();
  }
}
