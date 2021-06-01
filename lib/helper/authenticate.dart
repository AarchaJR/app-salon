import 'package:flutter/material.dart';
import 'package:projectsalon/pages/login_page.dart';
import 'package:projectsalon/pages/signup_page.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
 Widget build(BuildContext context) {
    if(showSignIn) {
      return SignIn(toggleView);
    }
    else {
      return SignUp(toggleView);
    }
  }
}