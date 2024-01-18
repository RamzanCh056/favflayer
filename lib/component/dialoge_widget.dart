import 'package:flutter/material.dart';

Widget titleForDialog(BuildContext context, String title) {
  return Container(
    color: Theme.of(context).primaryColor,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
    child: Center(
      child: Text(title,
          style:
          const TextStyle(color: Colors.white, fontSize: 17, height: 1.55),
          textAlign: TextAlign.center),
    ),
  );
}