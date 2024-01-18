import 'package:dio/dio.dart';
import 'package:ffadvertisement/component/circle_progress_indicator.dart';
import 'package:ffadvertisement/component/my_app_bar.dart';
import 'package:ffadvertisement/utils/api_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class Privacy extends StatefulWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  String contentText = '';
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getContent();
  }

  void getContent() async {
    var response = await Dio().get(ApiUrls().privacy.toString()).then((value) {
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
                          "Privacy Policy",
                          style:
                              TextStyle(color: Color(0xffffffff), fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        Center(
          child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child:Text(
              "These terms of use explain how you may use this App References in these terms to the App includes the following website www.favoriteflyer.com and all associated web pages. You should read these terms and conditions carefully before using the App. By accessing or using this App or otherwise indicating your consent, you agree to be bound by these terms and conditions and the documents referred to in them. If you do not agree with or accept any of these terms, you should cease using the App immediately. If you have any questions about the App, please contact ___email address for support_____."
              , style: TextStyle(color: Colors.white, fontSize: 16),
              ),))),
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
}
