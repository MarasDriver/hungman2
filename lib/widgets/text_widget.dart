import 'package:flutter/material.dart';

class MyTextWidget extends StatelessWidget {
  const MyTextWidget({Key? key, this.text, this.size}) : super(key: key);

  final String? text;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
        fontFamily: "Schyler",
        fontWeight: FontWeight.bold,
        fontSize: 35.0,
      ),
    );
  }
}
