import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final String title;
  final double height;
  final double width;
  final double fontSize;
  final Color color;
  final double radius;
  ReusableButton({
    Key? key,
    required this.title,
    this.color = Colors.blueGrey,
    this.height = 50,
    this.width = 215,
    this.fontSize = 16,  this.radius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(radius)),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: Color(0xffFBFCFD),
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
