// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final String imageSrc;
  final onTap;
  const MyListTile({
    Key? key,
    required this.title,
    required this.imageSrc,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap ?? () {},
      leading: Image.asset(
        imageSrc,
        width: 25,
        height: 25,
      ),
      title: AutoSizeText(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      minLeadingWidth: 20,
      tileColor: const Color(0xFF292839),
      iconColor: const Color(0xFF6AA71A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(05),
      ),
    );
  }
}
