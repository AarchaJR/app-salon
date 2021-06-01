import 'package:flutter/material.dart';
import 'package:projectsalon/constants.dart';

class Cardd extends StatelessWidget {
  final String image;
  final Function pressdet;
  const Cardd({
    Key,
    key,
    this.image,
    this.pressdet,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pressdet,
      child: Container(
        margin: EdgeInsets.only(left: 24, bottom: 20),
        height: 200,
        width: 150,
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 10,
              left: 0,
              right: 10,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Image.asset(image, width: 150),
                ),
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 33,
                        color: kShadowColor),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
