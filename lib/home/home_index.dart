// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names, import_of_legacy_library_into_null_safe

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffadvertisement/onboarding/consts.dart';
import 'package:ffadvertisement/utils/api_url.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:ffadvertisement/component/circle_progress_indicator.dart';
import 'package:ffadvertisement/component/my_app_bar.dart';
import 'package:ffadvertisement/component/no_data_text.dart';
import 'package:ffadvertisement/home/category_ads.dart';
import 'package:ffadvertisement/utils/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'add_details.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePageContent> createState() => HomePageContentState();
}

class HomePageContentState extends State<HomePageContent> {
  late List bussinessCategory;
  bool _isLoading = true;
  List data = [];

  @override
  void initState() {
    bussinessCategory = [];
    super.initState();
    printSharedPreferencesData();
   // getCategory();
     getCatagories();
    fetchData();
  }
  String? name ;
  String? zipCode ;
  String? age ;
  String? country ;
  String? gender;
  String? fcmToken;
  String? minAge;

  void printSharedPreferencesData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name') ?? 'N/A';
    zipCode = prefs.getString('zipCode') ?? 'N/A';
    age = prefs.getString('age') ?? 'N/A';
    country = prefs.getString('country') ?? 'N/A';
    gender = prefs.getString('gender') ?? 'N/A';
    fcmToken = prefs.getString('fcmToken') ?? 'N/A';
    minAge = prefs.getString('minAge') ?? 'N/A';

    print('Name: $name');
    print('Zip Code: $zipCode');
    print('Age: $age');
    print('Country: $country');
    print('Gender: $gender');
    print('token: $fcmToken');
    print('minAge: $minAge');
  }
  getCatagories() async {
    printSharedPreferencesData();
    var headers = {
      'Cookie':
      'x-clockwork=%7B%22requestId%22%3A%221690967253-5519-388169370%22%2C%22version%22%3A%225.1.12%22%2C%22path%22%3A%22%5C%2F__clockwork%5C%2F%22%2C%22webPath%22%3A%22%5C%2Fclockwork%5C%2Fapp%22%2C%22token%22%3A%2269aea927%22%2C%22metrics%22%3Atrue%2C%22toolbar%22%3Atrue%7D'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
          //'http://favoriteflyer.ca/api/auth-categories?min_age=61&max_age=65&zipcode=58000&country=Pakistan&fcm_token=12345qwertyasd&gender=Male'

            'http://favoriteflyer.ca/api/auth-categories?min_age=${minAge}&max_age=${age}&zipcode=${zipCode}&country=${country}&fcm_token=${fcmToken}&gender=${gender}'
              ));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var res = await response.stream.bytesToString();
      var body = jsonDecode(res);
      dataList = body['data'];
      print("here dataList ${dataList}");
      setState(() {
        dataList;
      });
      setState(() {
        _isLoading = false;
      });
    } else {
      print(response.reasonPhrase);
      setState(() {
        _isLoading = false;
      });
    }
  }

  final storageService = StorageService();

  List<String> images = [
    "images/ashkan.jpg",
    "images/edward.jpg",
    "images/jason.jpg",
    "images/peter.jpg",
    "images/rachel.jpg",
    "images/senjuti.jpg",
    "images/ashkan.jpg",
    "images/edward.jpg",
    "images/jason.jpg",
    "images/peter.jpg",
    "images/rachel.jpg",
    "images/senjuti.jpg",
    "images/ashkan.jpg",
    "images/edward.jpg",
    "images/jason.jpg",
    "images/peter.jpg",
    "images/rachel.jpg",
    "images/senjuti.jpg",
    "images/jason.jpg",
    "images/peter.jpg",
    "images/rachel.jpg",
    "images/senjuti.jpg",
    "images/peter.jpg",
    "images/rachel.jpg",
    "images/senjuti.jpg",
  ];

  final List<Map<String, dynamic>> items = [];
  var dataList = [];

  Future<List<Map<String, dynamic>>> fetchData() async {
    final querySnapshot =
    await FirebaseFirestore.instance.collection(fcmToken.toString()).get();

    querySnapshot.docs.forEach((doc) {
      final data = doc.data() as Map<String, dynamic>;
      items.add(data);
    });

    setState(() {
      items;
      print("item is here ${items[0]['id']}");
    });
    getCatagories();
    return items;
  }

  @override
  Widget build(BuildContext context) {
    // Create a map to store items in dataList based on their id
    final Map<String, dynamic> dataMap = {};
    dataList.forEach((item) {
      dataMap[item['id'].toString()] = item;
    });
    final filteredDataList = items
        .map((item) => dataMap[item['id'].toString()])
        .where((item) => item != null)
        .toList();
    return Scaffold(
      appBar: const MyAppBar(),
      backgroundColor: Theme.of(context).primaryColor,
      body: _isLoading
          ? const CircularProgressIndicator()
          : Container(
        padding: const EdgeInsets.all(16),
        child:
        dataList.isNotEmpty?

        (items.isEmpty)
            ? ListView.builder(
          itemCount: dataList.length,
          itemBuilder: (BuildContext, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddDetails(
                        data: dataList[index]["data"],
                        baseAddName: dataList[index]["name"],
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(images[index]),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3),
                        BlendMode.dstATop,
                      ),
                    ),
                    border: Border.all(
                      color: const Color(0xff4D4C51),
                    ),
                    color: const Color(0xFF292839),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(images[index]),
                        radius: 27,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 8,
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              dataList[index]["name"].toString(),
                              maxLines: 1,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 12),
                              child: AutoSizeText(
                                dataList[index]["description"]
                                    .toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )
            : ListView.builder(
          itemCount: filteredDataList.length,
          itemBuilder: (BuildContext, index) {
            if (filteredDataList.isEmpty) {
              return Center(
                child: Container(
                  child: Center(
                    child: Text("No match found", style: TextStyle(color: Colors.white, fontSize: 20),),
                  ),
                ),
              );
            }

            final matchingItem = filteredDataList[index];


            if (matchingItem == null) {
              return SizedBox.shrink(); // Hide non-matching items
            }

            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddDetails(
                        data: matchingItem["data"],
                        baseAddName: matchingItem["name"],
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(images[index]),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3),
                        BlendMode.dstATop,
                      ),
                    ),
                    border: Border.all(
                      color: const Color(0xff4D4C51),
                    ),
                    color: const Color(0xFF292839),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(images[index]),
                        radius: 27,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 8,
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              matchingItem["name"].toString(),
                              maxLines: 1,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 12),
                              child: AutoSizeText(
                                matchingItem["description"]
                                    .toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ) : const NoDataText(),
      ),
    );
  }
}
