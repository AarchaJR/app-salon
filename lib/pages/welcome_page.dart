import 'package:flutter/material.dart';
import 'package:projectsalon/animations/sliding_animations.dart';
import 'package:projectsalon/helper/authenticate.dart';
import 'package:projectsalon/helper/helperfunctions.dart';
import 'package:projectsalon/main_page/main_page.dart';
import 'package:projectsalon/pages/login_page.dart';
import 'package:projectsalon/pages/signup_page.dart';
import 'package:projectsalon/widgets/Rounded_button.dart';

class FrontPage extends StatefulWidget {
  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  bool userIsLoggedIn = false;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        if (value == null)
          userIsLoggedIn = false;
        else
          userIsLoggedIn = value;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/frontpic.png',
              ),
              fit: BoxFit.fill),
        ),
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 175.0),
            child: RichText(
              text: TextSpan(
                text: 'Salon Connect',
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 55.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
          SizedBox(
            height: 300,
          ),
          SizedBox(
            width: 34,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: RoundedButton(
                text: 'jump In',
                fontSize: 20,
                press: () {
                  Navigator.push(
                    context,
                    SlideLeftRoute(
                        page: userIsLoggedIn ? MainPage() : Authenticate()),
                  );
                }),
          ),
        ]),
      ),
    );
  }
}
