import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectsalon/main_page/chatRoomScreen.dart';
import 'package:projectsalon/animations/FadeAnimation.dart';
import 'package:projectsalon/helper/authenticate.dart';
import 'package:projectsalon/helper/helperfunctions.dart';
import 'package:projectsalon/services/auth.dart';
import 'package:projectsalon/services/database.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  QuerySnapshot searchSnap;
  QuerySnapshot snap;
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  DatabaseMethods databaseMethods1 = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  TextEditingController FNameTextEditingController =
      new TextEditingController();
  TextEditingController LNameTextEditingController =
      new TextEditingController();
  TextEditingController addressTextEditingController =
      new TextEditingController();
  TextEditingController phoneNumberTextEditingController =
      new TextEditingController();

  signMeUp() {
    if (formKey.currentState.validate()) {
      List<String> FollowsMe = [];
      List<String> IFollowThem = [];

      Map<String, dynamic> userInfoMap = {
        "name": userNameTextEditingController.text,
        "fname": FNameTextEditingController.text,
        "lname": LNameTextEditingController.text,
        "email": emailTextEditingController.text,
        "displaypic": "",
        "tpic": "",
        "followers": "0",
        "following": "0",
        "posts": "0",
        "followsme": FollowsMe,
        "ifollowthem": IFollowThem,
        "bio": "",
        "searchname": userNameTextEditingController.text.toLowerCase(),
        "phonenumber": phoneNumberTextEditingController.text,
        "address": addressTextEditingController.text
      };
      HelperFunctions.saveUserEmailSharedPreference(
          emailTextEditingController.text);
      HelperFunctions.saveUserNameSharedPreference(
          userNameTextEditingController.text);
      setState(() {
        isLoading = true;
      });

      authMethods
          .signUpWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((val) {
        databaseMethods.uploadUserInfo(userInfoMap);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Authenticate()));
      });
    }
  }

  bool doesExist = false;
  bool emailExist = false;
  checking<bool>(String val) {
    databaseMethods.getUserByUsernameForSearch(val.toLowerCase()).then((value) {
      setState(() {
        print(value);
        searchSnap = value;
      });
    });
    print(searchSnap.size);
    if (searchSnap.size == 1)
      setState(() {
        doesExist = true;
      });
    else
      setState(() {
        doesExist = false;
      });
    print(doesExist);
    return doesExist;
  }

  checkingEmail<bool>(String val) {
    databaseMethods1.getUserByUserEmail(val).then((value) {
      setState(() {
        print(value);
        snap = value;
      });
    });
    print(snap.size);
    if (snap.size == 1)
      setState(() {
        emailExist = true;
      });
    else
      setState(() {
        emailExist = false;
      });
    print(emailExist);
    return emailExist;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Container(
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //       alignment: Alignment.topCenter,
              //       image: AssetImage('assets/images/frontpic.png'),
              //       fit: BoxFit.fill),
              // ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 460,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 6,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(196, 135, 198, .3),
                                    blurRadius: 20,
                                    offset: Offset(0, 10),
                                  )
                                ]),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextFormField(
                                      validator: (val) {
                                        return val.isEmpty
                                            ? 'Please provide a valid First Name'
                                            : null;
                                      },
                                      controller: FNameTextEditingController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "First Name",
                                          hintStyle:
                                              TextStyle(color: Colors.grey)),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextFormField(
                                      validator: (val) {
                                        return val.isEmpty
                                            ? 'Please provide a valid Last Name'
                                            : null;
                                      },
                                      controller: LNameTextEditingController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Last Name",
                                          hintStyle:
                                              TextStyle(color: Colors.grey)),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextFormField(
                                      onChanged: checking,
                                      validator: (val) =>
                                          val.isEmpty || val.indexOf(" ") >= 0
                                              ? 'Please provide valid username'
                                              : checking(val)
                                                  ? 'Username already exists'
                                                  : null,
                                      controller: userNameTextEditingController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Username",
                                          hintStyle:
                                              TextStyle(color: Colors.grey)),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextFormField(
                                      validator: (val) {
                                        return val.length == 10
                                            ? null
                                            : 'Please provide valid mobile number';
                                      },
                                      controller:
                                          phoneNumberTextEditingController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Mobile Number",
                                          hintStyle:
                                              TextStyle(color: Colors.grey)),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextFormField(
                                      controller: addressTextEditingController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Address",
                                          hintStyle:
                                              TextStyle(color: Colors.grey)),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextFormField(
                                      onChanged: checkingEmail,
                                      validator: (val) =>
                                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                  .hasMatch(val)
                                              ? checkingEmail(val) == false
                                                  ? null
                                                  : 'Email is already in use'
                                              : 'Please provide valid email',
                                      controller: emailTextEditingController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Email",
                                          hintStyle:
                                              TextStyle(color: Colors.grey)),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: TextFormField(
                                      obscureText: true,
                                      validator: (val) {
                                        return val.length >= 6
                                            ? null
                                            : 'Please provide password with atleast 6 characters';
                                      },
                                      controller: passwordTextEditingController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Password",
                                          hintStyle:
                                              TextStyle(color: Colors.grey)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              signMeUp();
                            },
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 60),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey[600],
                              ),
                              child: Center(
                                child: Text(
                                  "Register",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                              child: GestureDetector(
                                  onTap: () {
                                    widget.toggle();
                                  },
                                  child: Text(
                                    "Log in",
                                    style: TextStyle(color: Colors.white),
                                  ))),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
