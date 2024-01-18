// ignore_for_file: import_of_legacy_library_into_null_safe, use_build_context_synchronously

import 'package:ffadvertisement/utils/api_url.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:ffadvertisement/component/circle_progress_indicator.dart';
import 'package:ffadvertisement/component/my_app_bar.dart';
import 'package:ffadvertisement/component/my_list_tile.dart';
import 'package:ffadvertisement/notification/singleFlyer.dart';
import 'package:ffadvertisement/utils/storage_service.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List notificationData = [];
  dynamic userId;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    justCall();
  }

  void justCall() async {
    userId = await StorageService().readSecureData("user_id");

    var res = Dio().get("${ApiUrls().notifications}$userId").then((value) {
      if (value.data.isNotEmpty) {
        setState(() {
          isLoading = false;
          notificationData = value.data;
        });
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
      body: isLoading
          ? const CircleProgressIndicator()
          : notificationData.isNotEmpty
              ? SafeArea(
                  child: RefreshIndicator(
                    backgroundColor: const Color(0xFF292839),
                    color: const Color(0xFF6AA71A),
                    onRefresh: () async {
                      var res =
                          await Dio().get("${ApiUrls().notifications}$userId");

                      if (res.data.isNotEmpty) {
                        setState(() {
                          notificationData = res.data;
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const MyListTile(
                            title: "Notifications",
                            imageSrc: "assets/ios-notifications.png",
                            onTap: null,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: notificationData.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    var res = await Dio().post(
                                      ApiUrls().notificationRead.toString(),
                                      data: {
                                        "id": notificationData[index]
                                                ["notification_id"]
                                            .toString(),
                                      },
                                    );
                                    if (res.statusCode == 200) {
                                      setState(() {
                                        notificationData[index]["read_at"] =
                                            "1";
                                      });
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SingleFlyer(
                                              flyerId: notificationData[index]
                                                      ["flyer_id"]
                                                  .toString()),
                                        ),
                                      );
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 08,
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 60,
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 08, 10, 08),
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF292839),
                                          borderRadius:
                                              BorderRadius.circular(05)),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                const Color(0xFF6AA71A),
                                            radius: 20,
                                            foregroundImage: NetworkImage(
                                                notificationData[index]
                                                    ["upload_file"]),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: AutoSizeText(
                                              notificationData[index]["message"]
                                                  .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          if (notificationData[index]
                                                  ["read_at"] ==
                                              "0")
                                            const Align(
                                              alignment: Alignment.topCenter,
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Color(0xFF6AA71A),
                                                radius: 2,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const Center(
                  child: AutoSizeText(
                    "No Notification Found",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
    );
  }
}
