import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectsalon/animations/FadeAnimation.dart';
import 'package:projectsalon/helper/helperfunctions.dart';
import 'package:projectsalon/main_page/main_page.dart';
import 'package:projectsalon/services/auth.dart';
import 'package:projectsalon/services/database.dart';
import 'package:projectsalon/main_page/chatRoomScreen.dart';
import 'package:projectsalon/pages/signup_page.dart';

import 'forgetpassword.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  bool epCorrect = true;
  bool isVerified = true;
  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;

  signIn() {
    if (formKey.currentState.validate()) {
      HelperFunctions.saveUserEmailSharedPreference(
          emailTextEditingController.text);

      databaseMethods
          .getUserByUserEmail(emailTextEditingController.text)
          .then((val) {
        snapshotUserInfo = val;
        HelperFunctions.saveUserNameSharedPreference(
            snapshotUserInfo.docs[0].data()["name"]);
      });

      setState(() {
        isLoading = true;
      });

      authMethods
          .signInWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((val) {
        //if(val != null)
        if (val != "notv" && val != "nop" && val != null) {
          setState(() {
            epCorrect = true;
            isVerified = true;
          });
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainPage()));
        } else {
          print("wrong email/passsword");
          if (val == "notv")
            setState(() {
              isVerified = false;
              epCorrect = true;
            });
          else if (val == "nop") {
            setState(() {
              epCorrect = false;
              isVerified = true;
            });
          }
        }
      });
    }
  }

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage('assets/images/frontpic.png'),
              fit: BoxFit.fill),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 500,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
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
                                      bottom:
                                          BorderSide(color: Colors.grey[200]))),
                              child: TextFormField(
                                validator: (val) {
                                  return RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(val)
                                      ? null
                                      : 'Please provide valid email';
                                },
                                controller: emailTextEditingController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                obscureText: true,
                                validator: (val) {
                                  return val.length > 0
                                      ? null
                                      : 'Wrong password';
                                },
                                controller: passwordTextEditingController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    epCorrect == false
                        ? Text(
                            "Email / Password is wrong or doesn't exist!",
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              color: Colors.red,
                              fontSize: 17.0,
                            ),
                          )
                        : Container(),
                    epCorrect == false
                        ? SizedBox(
                            height: 8.0,
                          )
                        : Container(),
                    isVerified == false
                        ? Text(
                            "Email hasn't been verified!",
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              color: Colors.red,
                              fontSize: 17.0,
                            ),
                          )
                        : Container(),
                    isVerified == false
                        ? SizedBox(
                            height: 8.0,
                          )
                        : Container(),
                    Center(
                        child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPassword()));
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        signIn();
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
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                        child: GestureDetector(
                            onTap: () {
                              widget.toggle();
                            },
                            child: Text(
                              "Create Account",
                              style: TextStyle(color: Colors.white),
                            ))),
                    SizedBox(
                      height: 112,
                    ),
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
