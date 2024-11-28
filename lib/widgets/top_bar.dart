import 'package:flutter/material.dart';

import '../screens/home/home.dart';

class TopBar extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final String title;
  const TopBar(
      {super.key,
      required this.screenWidth,
      required this.screenHeight,
      required this.title});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
          child: Container(
            height: screenHeight * 0.16,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: screenWidth * 0.07,
            ),
          ),
        ),
        Text(
          '$title',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.05),
        ),
        Container()
      ],
    );
  }
}
