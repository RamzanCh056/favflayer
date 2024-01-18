import 'package:dio/dio.dart';
import 'package:ffadvertisement/component/circle_progress_indicator.dart';
import 'package:ffadvertisement/component/my_app_bar.dart';
import 'package:ffadvertisement/utils/api_url.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  String contentText = '';
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getContent();
  }

  void getContent() async {
    var response = Dio().get(ApiUrls().aboutUs.toString()).then((value) {
      setState(() {
        contentText = value.data["description"].toString();
        isLoading = true;
      });
    }).catchError((onError) {
      setState(() {
        isLoading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(),
        backgroundColor: Theme.of(context).primaryColor,
        body: isLoading
            ? SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "About Us",
                          style:
                              TextStyle(color: Color(0xffffffff), fontSize: 20),
                        ),

                        // HtmlWidget(content.data.description),
                        const SizedBox(
                          height: 20,
                        ),

 Container(
    // Setting background color
        padding: EdgeInsets.all(5),
        child:
        // Center(
        //   child: Center(
        //   child: Padding(
        //     padding: EdgeInsets.all(8.0),
        //     child:Text(
        //       "Favorite Flyer is a revolutionary promotional platform that wants to stop wasteful paper flyers. Around 250 million trees get cut down every year to make those flyers you throw away. That’s a forest the size of Florida. That’s shameful waste ): The Favorite Flyer gives you the choice of who you get promotional content from. We put every business into categories, you select the categories you are interested in, and we send you money saving coupons, flyers, and promotions from brands in those categories.  Turn on location services to receive EXCLUSIVE Real Time Promotion alerts. Your favorite brands can now send you enticing offers when you are in walking distance of their store! Our website favoriteflyer.com makes it simple for any business owner to create a custom promotional campaign. By giving every business an alternative to paper flyer advertising, Favorite Flyer can offer our users the exact content you want, with out the paper waste! #savemoneysavetimesavetheplanet"
        //       , style: TextStyle(color: Colors.white, fontSize: 16),
        //       ),
         
         
        //   ),
        // ),
      
        // ),


Center(
        child: RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.white, fontSize: 16),
            children: [
              TextSpan(
                text:
                    "Favorite Flyer is a revolutionary promotional platform that wants to stop wasteful paper flyers. Around 250 million trees get cut down every year to make those flyers you throw away. That’s a forest the size of Florida. That’s shameful waste ): The Favorite Flyer gives you the choice of who you get promotional content from. We put every business into categories, you select the categories you are interested in, and we send you money saving coupons, flyers, and promotions from brands in those categories.  Turn on location services to receive EXCLUSIVE Real Time Promotion alerts. Your favorite brands can now send you enticing offers when you are in walking distance of their store! Our website ",
              ),
              TextSpan(
                text: "favoriteflyer.com",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _launchURL('http://favoriteflyer.ca/');
                  },
              ),
              TextSpan(
                text:
                    " makes it simple for any business owner to create a custom promotional campaign. By giving every business an alternative to paper flyer advertising, Favorite Flyer can offer our users the exact content you want, without the paper waste! #savemoneysavetimesavetheplanet",
              ),
            ],
          ),
        ),
      ),

      ),

                           const SizedBox(
                          height: 20,
                        ),
                        Html(
                          data: contentText,
                          style: {
                            // text that renders h1 elements will be red
                            "h1": Style(color: Colors.white),
                            "h2": Style(color: Colors.white),
                            "h3": Style(color: Colors.white),
                            "h4": Style(color: Colors.white),
                            "h5": Style(color: Colors.white),
                            "h6": Style(color: Colors.white),
                            "p": Style(color: Colors.white),
                            "span": Style(color: Colors.white),
                            "label": Style(color: Colors.white),
                            "strong": Style(color: Colors.white),
                            "div": Style(color: Colors.white),
                            "ul": Style(color: Colors.white),
                            "li": Style(color: Colors.white),
                            "ol": Style(color: Colors.white),
                            "pre": Style(color: Colors.white),
                            "b": Style(color: Colors.white),
                            "i": Style(color: Colors.white),
                            "a": Style(color: Colors.white),
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const Center(child: CircleProgressIndicator()));
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
