import 'package:flutter/material.dart';
import 'package:projectsalon/constants.dart';
import 'package:projectsalon/helper/authenticate.dart';
import 'package:projectsalon/helper/helperfunctions.dart';
import 'package:projectsalon/main_page/main_page.dart';
import 'package:projectsalon/pages/details.dart';
import 'package:projectsalon/services/auth.dart';
import 'package:projectsalon/widgets/search1.dart';

const stylistData = [
  {
    'salonName': 'Fair Salon',
    'location': 'Kannamoola',
    'rating': '4.8',
    'rateAmount': '56',
    'imgUrl': 'assets/images/fair.jpg',
    'bgColor': kTextColor,
  },
  {
    'salonName': 'Tony & Guy',
    'location': 'Sastamangalam',
    'rating': '4.7',
    'rateAmount': '80',
    'imgUrl': 'assets/images/tony.jpg',
    'bgColor': kTextColor,
  },
  {
    'salonName': 'Ashtamudi',
    'location': 'Nandavanam',
    'rating': '4.7',
    'rateAmount': '70',
    'imgUrl': 'assets/images/ashtamudi.jpg',
    'bgColor': kTextColor,
  },
  {
    'salonName': 'Ambikapillai beauty salon',
    'location': 'vazhutacaud',
    'rating': '4.6',
    'rateAmount': '70',
    'imgUrl': 'assets/images/Ambika.jpg',
    'bgColor': kTextColor,
  }
];

class HomeScreen extends StatelessWidget {
  AuthMethods authMethods = new AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: SingleChildScrollView(
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
                          authMethods.signOut();
                          HelperFunctions.saveUserLoggedInSharedPreference(
                              false);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Authenticate()));
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return SearchScreen();
                            }),
                          );
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
                            'Top Rated Salons',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.black,
                              fontSize: 29,
                            ),
                          ),
                          SingleChildScrollView(
                            child: Container(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    StylistCard(stylistData[0], 'FAIR SALON'),
                                    StylistCard(stylistData[1], 'TONI&GUY'),
                                    StylistCard(stylistData[2],
                                        'Ashtamudi Beauty Salon'),
                                    StylistCard(stylistData[3],
                                        'Ambikapillai beauty salon'),
                                    SizedBox(
                                      height: 200,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StylistCard extends StatelessWidget {
  final salon;
  final stylist;
  StylistCard(this.stylist, this.salon);

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
            top: -100,
            right: -60,
            child: Image.asset(
              stylist['imgUrl'],
              width: MediaQuery.of(context).size.width * 0.60,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 40, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  stylist['salonName'],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
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
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      size: 18,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      stylist['rating'],
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailScreen(
                                  salonname: salon,
                                )));
                  },
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'View Profile',
                    style: TextStyle(
                      fontSize: 15,
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
