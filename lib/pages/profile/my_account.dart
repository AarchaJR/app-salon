import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectsalon/helper/helperfunctions.dart';
import 'package:projectsalon/services/database.dart';

import '../../constants.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
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
  String address;
  String mob;

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
    address = searchSnapshot.docs[0].data()["address"];
    mob = searchSnapshot.docs[0].data()["phonenumber"];

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
                      height: 180,
                      width: 180,
                      child: Stack(
                        fit: StackFit.expand,
                        overflow: Overflow.visible,
                        children: [
                          // CircleAvatar(
                          //   backgroundImage: dp == ""
                          //       ? NetworkImage(
                          //           "https://slcp.lk/wp-content/uploads/2020/02/no-profile-photo.png")
                          //       : NetworkImage(dp),
                          // )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ProfileMenu(
                      text: "$Fname $Lname",
                      leading: "Name    ",
                      press: () {},
                    ),
                    ProfileMenu(
                      text: "$userName",
                      leading: "Username",
                      press: () {},
                    ),
                    ProfileMenu(
                      text: "$userEmail",
                      leading: "Email   ",
                      press: () {},
                    ),
                    ProfileMenu(
                      text: "$address",
                      leading: "Address ",
                      press: () {},
                    ),
                    ProfileMenu(
                      text: "$mob",
                      leading: "Phone No",
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
    @required this.leading,
    this.press,
  }) : super(key: key);

  final String text, leading;
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${leading}:",
              style: TextStyle(fontSize: 23),
            ),
            SizedBox(
              width: 30,
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 23),
              ),
            ),
            // Icon(
            //   Icons.arrow_forward_ios,
            //   color: Colors.transparent,
            // )
          ],
        ),
      ),
    );
  }
}

// bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
