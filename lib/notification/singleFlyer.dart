// ignore_for_file: file_names, sized_box_for_whitespace

import 'package:ffadvertisement/utils/api_url.dart';
import 'package:dio/dio.dart';
import 'package:ffadvertisement/component/circle_progress_indicator.dart';
import 'package:ffadvertisement/component/flyer_post.dart';
import 'package:ffadvertisement/component/my_app_bar.dart';
import 'package:ffadvertisement/component/no_data_text.dart';
import 'package:ffadvertisement/utils/storage_service.dart';
import 'package:flutter/material.dart';

class SingleFlyer extends StatefulWidget {
  const SingleFlyer({Key? key, required this.flyerId}) : super(key: key);
  final String flyerId;

  @override
  State<SingleFlyer> createState() => _SingleFlyerState();
}

class _SingleFlyerState extends State<SingleFlyer> {
  Map flyer = {};
  dynamic userId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    justCall();
  }

  void justCall() async {
    userId = await StorageService().readSecureData("user_id");
    var res = await Dio()
        .get("${ApiUrls().single_ads}${widget.flyerId}")
        .then((value) {
      if (value.statusCode == 200) {
        setState(() {
          isLoading = false;
          flyer = value.data;
        });
        Dio().post(
          ApiUrls().impressions.toString(),
          data: {
            "user_id": userId,
            "flyer_id": widget.flyerId,
          },
        );
      } else {
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: isLoading
            ? const CircleProgressIndicator()
            : flyer.isEmpty
                ? const NoDataText()
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.55,
                      child: FlyerPost(
                        name: flyer["name"].toString(),
                        imageSrc: flyer["file"],
                        viewNum: flyer["views"].toString(),
                      ),
                    ),
                  ),
      ),
    );
  }
}
