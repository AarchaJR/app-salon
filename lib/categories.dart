import 'package:flutter/material.dart';
import 'package:projectsalon/cardd.dart';
import 'package:projectsalon/constants.dart';
import 'package:projectsalon/pages/categories/face.dart';
import 'package:projectsalon/pages/categories/hair.dart';
import 'package:projectsalon/pages/categories/products.dart';
import 'package:projectsalon/pages/categories/skin.dart';
import 'package:projectsalon/pages/categories/treatments.dart';
import 'package:projectsalon/pages/categories/wedding.dart';

import 'pages/categories/face.dart';
import 'pages/categories/hair.dart';
import 'pages/categories/products.dart';
import 'pages/categories/skin.dart';
import 'pages/categories/treatments.dart';
import 'pages/categories/wedding.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.display1,
                children: [
                  TextSpan(
                    text: "CATEGORIES",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Cardd(
                    image: "assets/images/hair.png",
                    pressdet: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Hair();
                          },
                        ),
                      );
                    }),
                Cardd(
                    image: "assets/images/face.png",
                    pressdet: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Face();
                          },
                        ),
                      );
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Cardd(
                    image: "assets/images/products.png",
                    pressdet: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Products();
                          },
                        ),
                      );
                    }),
                Cardd(
                    image: "assets/images/skin.png",
                    pressdet: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Skin();
                          },
                        ),
                      );
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Cardd(
                    image: "assets/images/wedding.png",
                    pressdet: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Wedding();
                          },
                        ),
                      );
                    }),
                Cardd(
                    image: "assets/images/treatments.png",
                    pressdet: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Treatments();
                        },
                      ));
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
