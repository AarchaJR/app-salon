import 'package:flutter/material.dart';
import 'package:projectsalon/pages/details.dart';
import 'package:projectsalon/constants.dart';

const stylistData = [
  {
    'salonName': 'Botox\nTreatment',
    'location': '500',
    'imgUrl': 'assets/images/botox.jpg',
    'bgColor': kTextColor,
  },
  {
    'salonName': 'Exfoliation',
    'location': '2000',
    'imgUrl': 'assets/images/exfoliation.jpg',
    'bgColor': kTextColor,
  },
  {
    'salonName': 'Hydrotherapy',
    'location': '400',
    'imgUrl': 'assets/images/Hydrotherapy.jpg',
    'bgColor': kTextColor,
  },
  {
    'salonName': 'Artificial\nnailfixing',
    'location': '4500',
    'imgUrl': 'assets/images/artifialnailfixing.jpg',
    'bgColor': kTextColor,
  },
  {
    'salonName': 'Laser\ntreatment',
    'location': '6800',
    'imgUrl': 'assets/images/laser.jpg',
    'bgColor': kTextColor,
  },
  {
    'salonName': 'Nailart',
    'location': '6800',
    'imgUrl': 'assets/images/nailart.jpg',
    'bgColor': kTextColor,
  },
  {
    'salonName': 'De-tan',
    'location': '6800',
    'imgUrl': 'assets/images/de-tan.jpg',
    'bgColor': kTextColor,
  },
];

class Treatments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(50),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          'AVAILABLE',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                            fontSize: 27,
                          ),
                        ),
                        StylistCard(stylistData[0]),
                        StylistCard(stylistData[1]),
                        StylistCard(stylistData[2]),
                        StylistCard(stylistData[3]),
                        StylistCard(stylistData[4]),
                        StylistCard(stylistData[5]),
                        SizedBox(
                          height: 150,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StylistCard extends StatelessWidget {
  final stylist;
  StylistCard(this.stylist);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4 - 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: stylist['bgColor'],
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: -55,
            right: -1,
            child: Image.asset(
              stylist['imgUrl'],
              width: MediaQuery.of(context).size.width * 0.60,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 40, left: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  stylist['salonName'],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 23,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  stylist['location'],
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailScreen()));
                  },
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'View',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
