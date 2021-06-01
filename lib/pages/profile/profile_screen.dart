import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectsalon/constants.dart';
import 'package:projectsalon/helper/helperfunctions.dart';
import 'package:projectsalon/pages/profile/bodyy.dart';
import 'package:projectsalon/pages/profile/edit.dart';

import 'package:projectsalon/pages/profile/my_account.dart';
import 'package:projectsalon/services/database.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot searchSnapshot;
  DatabaseMethods databaseMethods10 = new DatabaseMethods();
  QuerySnapshot searchSnapshot10;

  String userName;
  String userEmail;
  String batch;
  String Fname;
  String Lname;
  String dp;
  String tp;
  String posts;
  String followers;
  String following;
  String bio;

  bool isLoading = true;

  initSearch() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    print(Constants.myName);
    await databaseMethods.getUserByUsername(Constants.myName).then((val) {
      if (mounted)
        setState(() {
          searchSnapshot = val;
        });
    });
    userName = searchSnapshot.docs[0].data()["name"];
    userEmail = searchSnapshot.docs[0].data()["email"];
    batch = searchSnapshot.docs[0].data()["batch"];
    Fname = searchSnapshot.docs[0].data()["fname"];
    Lname = searchSnapshot.docs[0].data()["lname"];
    dp = searchSnapshot.docs[0].data()["displaypic"];
    tp = searchSnapshot.docs[0].data()["tpic"];
    posts = searchSnapshot.docs[0].data()["posts"];
    followers = searchSnapshot.docs[0].data()["followers"];
    following = searchSnapshot.docs[0].data()["following"];
    bio = searchSnapshot.docs[0].data()["bio"];

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
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 150,
                    ),
                    SizedBox(
                      height: 115,
                      width: 115,
                      child: Stack(
                        fit: StackFit.expand,
                        overflow: Overflow.visible,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(dp),
                          ),
                          Positioned(
                            right: -16,
                            bottom: 0,
                            child: SizedBox(
                              height: 46,
                              width: 46,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(color: Colors.white),
                                ),
                                color: Color(0xFFF5F6F9),
                                onPressed: () {},
                                child: Image.asset("assets/images/camera.png"),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ProfileMenu(
                      text: "My Account",
                      icon: "assets/images/user.png",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return MyAccount();
                          }),
                        );
                      },
                    ),
                    ProfileMenu(
                      text: "Notifications",
                      icon: "assets/images/notification.png",
                      press: () {},
                    ),
                    ProfileMenu(
                      text: "Edit Profile",
                      icon: "assets/images/settings.png",
                      press: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) {
                        //     return Edit();
                        //   }),
                        // );
                      },
                    ),
                    ProfileMenu(
                      text: "Help Center",
                      icon: "assets/images/information.png",
                      press: () {},
                    ),
                    ProfileMenu(
                      text: "Log Out",
                      icon: "assets/images/logout.png",
                      press: () {},
                    ),
                  ],
                ),
              ));
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key key,
    @required this.text,
    @required this.icon,
    this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.grey[200],
        onPressed: press,
        child: Row(
          children: [
            Image.asset(
              icon,
              color: Colors.grey[600],
              width: 25,
            ),
            SizedBox(width: 20),
            Expanded(child: Text(text)),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[800],
            )
          ],
        ),
      ),
    );
  }
}

// bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
