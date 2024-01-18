// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:async';

import 'package:ffadvertisement/utils/api_url.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:ffadvertisement/component/circle_progress_indicator.dart';
import 'package:ffadvertisement/component/flyer_post.dart';
import 'package:ffadvertisement/component/my_app_bar.dart';
import 'package:ffadvertisement/component/no_data_text.dart';
import 'package:ffadvertisement/utils/storage_service.dart';
import 'package:flutter/material.dart';

class CategoryAds extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const CategoryAds({
    Key? key,
    required this.categoryId,
    required this.categoryName,
  }) : super(key: key);

  @override
  State<CategoryAds> createState() => _CategoryAdsState();
}

class _CategoryAdsState extends State<CategoryAds> {
  final TextEditingController _searchBar = TextEditingController();
  final storageService = StorageService();
  late List adsList;
  List finalListData = [];
  List searchresult = [];

  PageController pageController = PageController(initialPage: 0);

  bool _isSearching = false;
  bool _isLoading = true;
  dynamic userId;

  @override
  void initState() {
    adsList = [];
    super.initState();
    getCategory();
  }

  void getCategory() async {
    userId = await storageService.readSecureData("user_id");

    var response = await Dio()
        .get(
      "${ApiUrls().advertismentCategory}${widget.categoryId}?u=$userId",
    )
        .then((value) {
      if (value.statusCode == 200) {
        List data = value.data;
        if (data.isNotEmpty) {
          setState(() {
            _isLoading = false;
            adsList = value.data;
            finalListData = adsList;
          });
          Timer(
              const Duration(
                days: 0,
                hours: 0,
                microseconds: 0,
                milliseconds: 0,
                minutes: 0,
                seconds: 3,
              ), () async {
            await Dio().post(
              ApiUrls().impressions.toString(),
              data: {
                "user_id": userId,
                "flyer_id": finalListData[0]['id'],
              },
            );
          });
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }).catchError((onError) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      backgroundColor: Theme.of(context).primaryColor,
      body: !_isLoading
          ? adsList.isNotEmpty
              ? SafeArea(
                  child: RefreshIndicator(
                    backgroundColor: const Color(0xFF292839),
                    color: const Color(0xFF6AA71A),
                    onRefresh: () async {
                      var response = await Dio().get(
                        "${ApiUrls().advertismentCategory}${widget.categoryId}?u=$userId",
                      );
                      List data = response.data;
                      if (data.isNotEmpty) {
                        setState(() {
                          adsList = response.data;
                          finalListData = adsList;
                        });
                      }
                      setState(() {
                        _isLoading = false;
                      });
                      Timer(
                          const Duration(
                            days: 0,
                            hours: 0,
                            microseconds: 0,
                            milliseconds: 0,
                            minutes: 0,
                            seconds: 3,
                          ), () async {
                        await Dio().post(
                          ApiUrls().impressions.toString(),
                          data: {
                            "user_id": userId,
                            "flyer_id": finalListData[0]['id'],
                          },
                        );
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: const Color(0xFF292839),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 10,
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: AutoSizeText(
                                      widget.categoryName,
                                      style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF292839),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                        topRight: Radius.circular(51),
                                        bottomRight: Radius.circular(51),
                                      ),
                                    ),
                                    child: Flex(
                                      direction: Axis.horizontal,
                                      children: [
                                        Flexible(
                                          flex: 8,
                                          child: TextField(
                                            controller: _searchBar,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              decoration: TextDecoration.none,
                                            ),
                                            textAlign: TextAlign.justify,
                                            cursorColor: Colors.white,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  bottomLeft:
                                                      Radius.circular(15),
                                                  topRight: Radius.circular(51),
                                                  bottomRight:
                                                      Radius.circular(51),
                                                ),
                                                borderSide: BorderSide.none,
                                              ),
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      20, 0, 0, 00),
                                              hintText: "Search",
                                              hintStyle: TextStyle(
                                                  color: Colors.white38),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 05,
                                        ),
                                        Flexible(
                                          flex: 2,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _isSearching = true;
                                                });
                                                Timer(
                                                    const Duration(seconds: 2),
                                                    () {
                                                  setState(() {
                                                    _isSearching = false;
                                                  });
                                                  searchresult.clear();
                                                  if (_searchBar
                                                      .text.isNotEmpty) {
                                                    for (int i = 0;
                                                        i < adsList.length;
                                                        i++) {
                                                      var data = adsList[i];
                                                      if (data['name']
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(_searchBar
                                                              .text
                                                              .toLowerCase())) {
                                                        searchresult.add(data);
                                                      }
                                                    }
                                                    setState(() {
                                                      finalListData =
                                                          searchresult;
                                                    });
                                                    // print(finalListData);
                                                  } else {
                                                    setState(() {
                                                      finalListData = adsList;
                                                    });
                                                  }
                                                });
                                              },
                                              child: Container(
                                                height: 60,
                                                width: 60,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF6AA71A),
                                                  borderRadius:
                                                      BorderRadius.circular(60),
                                                ),
                                                child: const Icon(
                                                  Icons.search,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: finalListData.isNotEmpty
                                  ? _isSearching
                                      ? const CircleProgressIndicator()
                                      : PageView.builder(
                                          itemCount: finalListData.length,
                                          scrollDirection: Axis.vertical,
                                          controller: pageController,
                                          onPageChanged: (int num) async {
                                            await Dio().post(
                                              "https://ffadvertisement.appscanada.net/api/impressions",
                                              data: {
                                                "user_id": userId,
                                                "flyer_id": finalListData[num]
                                                    ['id'],
                                              },
                                            );
                                          },
                                          itemBuilder: (context, index) {
                                            return FlyerPost(
                                                name: finalListData[index]
                                                        ["name"]
                                                    .toString(),
                                                imageSrc: finalListData[index]
                                                    ["file"],
                                                viewNum: finalListData[index]
                                                        ["views"]
                                                    .toString());
                                          },
                                        )
                                  : const NoDataText(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : const NoDataText()
          : const CircleProgressIndicator(),
    );
  }
}
