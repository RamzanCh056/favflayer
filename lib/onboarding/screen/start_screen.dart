import 'package:ffadvertisement/onboarding/consts/reusable_text.dart';
import 'package:ffadvertisement/onboarding/utils/app_color.dart';
import 'package:ffadvertisement/onboarding/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'location_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('images/white_logo 1.png'),
          ReusableText(
            textAlign: TextAlign.center,
            color: AppColor.greyColor,
            weight: FontWeight.w500,
            size: 19,
            title:
                'We will never share or sell the \n information you provide us. We use it \n only to get you money saving coupons,\n flyers, and promotions from \nyour favorite brands.',
          ),
          Expanded(
              child: SizedBox(
            height: 10,
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context)=> Location()));

                AppUtils.navigateTo(
                  context,

                  LocationScreen(),
                  //LocationScreen()
                );
              },
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
                    title: 'Next',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
