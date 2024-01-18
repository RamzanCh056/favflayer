import 'package:flutter/material.dart';

class AppUtils {
  static getHeight(BuildContext context, double height) {
    return MediaQuery.of(context).size.height * height;
  }

  static getWidth(BuildContext context, double width) {
    return MediaQuery.of(context).size.width * width;
  }

  static navigateTo(BuildContext context, Widget page) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => page));
  }
}
