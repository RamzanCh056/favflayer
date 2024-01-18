
import 'package:ffadvertisement/onboarding/consts/reusable_text.dart';
import 'package:ffadvertisement/onboarding/screen/start_screen.dart';
import 'package:ffadvertisement/onboarding/utils/app_color.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('images/white_logo 1.png'),
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: TextStyle(fontSize: 38, fontWeight: FontWeight.w600),
                  text: 'Welcome!\nto\n',
                  children: [
                    TextSpan(
                        text: 'FavoriteFlyer',
                        style: TextStyle(color: Color(0xFF88B172)))
                  ])),
          ReusableText(
              textAlign: TextAlign.center,
              color: AppColor.greyColor,
              weight: FontWeight.w500,
              size: 21,
              title:
                  'The app that help you save money, \nsave time, and save the planet.'),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>StartScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColor.buttonColor,
                    borderRadius: BorderRadius.circular(15)),
                height: 50,
                width: double.infinity,
                child: Center(
                  child: ReusableText(
                    size: 20,
                    color: AppColor.primaryWhite,
                    weight: FontWeight.w600,
                    title: 'Start',
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
