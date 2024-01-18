// ignore_for_file: avoid_unnecessary_containers, use_build_context_synchronously

import 'package:ffadvertisement/component/circle_progress_indicator.dart';
import 'package:ffadvertisement/component/input_field.dart';
import 'package:ffadvertisement/component/listitems.dart';
import 'package:ffadvertisement/component/my_app_bar.dart';
import 'package:ffadvertisement/component/my_drop_down.dart';
import 'package:ffadvertisement/home/home_index.dart';
import 'package:ffadvertisement/utils/storage_service.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';

import '../utils/api_url.dart';

class GeneralSetting extends StatefulWidget {
  const GeneralSetting({Key? key}) : super(key: key);

  @override
  State<GeneralSetting> createState() => _GeneralSettingState();
}

class _GeneralSettingState extends State<GeneralSetting> {
  // final storageService = StorageService();
  String genderValue = "1";
  var ageValue = "1";
  String countryValue = "US";
  TextEditingController zipCodeValue = TextEditingController();
  List<dynamic>? bussnessCategory;
  List itemList = [];
  List selectedList = [];
  Map<String, String> req = HashMap();
  bool postalCodeValidate = false;
  var gender = [
    "1",
    "2",
    "3",
  ];
  var genderName = [
    "Male",
    "Female",
    "Non Binary",
  ];
  var age = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
  ];
  var ageRange = [
    "18-25",
    "26-30",
    "31-35",
    "36-40",
    "41-45",
    "46-50",
    "51-55",
    "60-65",
    "65-70",
    "70+",
  ];
  // bool postalCodeValidate = false;
  bool zipRequestSend = false;
  bool formRequestSend = false;
  bool _isChange = false;
  bool isLoading = true;
  late ScaffoldMessengerState scaffoldMessenger;
  List userCategories = [];
  final storageService = StorageService();
  @override
  void initState() {
    super.initState();
    initailizeData();
  }

  late Response<dynamic> getUser;
  late Response<dynamic> getCategories;
  void initailizeData() async {
    var userId = await storageService.readSecureData("user_id");
    getUser = await Dio().get(
      "${ApiUrls().getuser}$userId",
    );
    getCategories = await Dio().get(ApiUrls().buisness_categories.toString());
    if (getCategories.data.isNotEmpty) {
      setState(() {
        userCategories = getUser.data['business_category'];
        selectedList = getUser.data['business_category'];
        countryValue = getUser.data['country'];
        isLoading = false;
        genderValue = getUser.data['gender'];
        ageValue = getUser.data['age'];
        zipCodeValue.text = getUser.data['zip_code'];
        bussnessCategory = getCategories.data;
        itemList = getCategories.data;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: const MyAppBar(),
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: isLoading
            ? const CircleProgressIndicator()
            : CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Container(
                            color: Theme.of(context).primaryColor,
                            child: Column(
                              children: [
                                ListTile(
                                  contentPadding:
                                      const EdgeInsets.only(left: 0),
                                  leading: Image.asset(
                                    "assets/ios-user-setting.png",
                                    width: 25,
                                    height: 25,
                                  ),
                                  title: const AutoSizeText(
                                    "General Settings",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  minLeadingWidth: 20,
                                  iconColor: const Color(0xFF6AA71A),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(05),
                                  ),
                                  trailing: _isChange
                                      ? InkWell(
                                          onTap: () async {
                                            setState(() {
                                              formRequestSend = true;
                                            });
                                            var userId = await StorageService()
                                                .readSecureData("user_id");

                                            req.addAll({
                                              "user_id": userId.toString(),
                                              "gender": genderValue,
                                              "age": ageValue.toString(),
                                              "zip_code": zipCodeValue.text,
                                              "buisness_category":
                                                  jsonEncode(selectedList),
                                              // "country": countryValue,
                                            });
                                            if (zipCodeValue.text.isEmpty) {
                                              scaffoldMessenger
                                                  .showSnackBar(const SnackBar(
                                                content:
                                                    Text("Please add ZIP code"),
                                              ));
                                              return;
                                            }
                                            if (selectedList.isEmpty) {
                                              scaffoldMessenger
                                                  .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Please Select Categories"),
                                              ));
                                              return;
                                            }
                                            Dio()
                                                .post(
                                              ApiUrls()
                                                  .general_setting
                                                  .toString(),
                                              data: req,
                                            )
                                                .then((value) {
                                              // if (value.data["success"]) {
                                              //   context
                                              //       .findAncestorStateOfType<
                                              //           HomePageContentState>()
                                              //       ?
                                              //   scaffoldMessenger.showSnackBar(
                                              //       SnackBar(
                                              //           content: Text(
                                              //               "${value.data['message']}")));
                                              //   setState(() {
                                              //     _isChange = false;
                                              //     formRequestSend = false;
                                              //   });
                                              // } else {
                                              //   scaffoldMessenger.showSnackBar(
                                              //       SnackBar(
                                              //           content: Text(
                                              //               "${value.data['message']}")));
                                              //   setState(() {
                                              //     formRequestSend = false;
                                              //   });
                                              // }
                                            }).catchError((onError) {
                                              setState(() {
                                                formRequestSend = false;
                                              });
                                              scaffoldMessenger
                                                  .showSnackBar(SnackBar(
                                                content: Text("$onError"),
                                              ));
                                            });
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.zero,
                                            child: Icon(
                                              Icons.check_circle,
                                              size: 28,
                                            ),
                                          ),
                                        )
                                      : formRequestSend
                                          ? Container(
                                              height: 20,
                                              width: 20,
                                              child:
                                                  const CircularProgressIndicator(
                                                color: Color(0xFF6AA71A),
                                              ),
                                            )
                                          : null,
                                ),
                                MyDropDown(
                                  label: "Gender",
                                  optionsList: gender,
                                  optionsName: genderName,
                                  value: genderValue,
                                  oncange: (String? newValue) {
                                    setState(() {
                                      genderValue = newValue!;
                                      _isChange = true;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                MyDropDown(
                                  label: "Age",
                                  optionsList: age,
                                  optionsName: ageRange,
                                  value: ageValue,
                                  oncange: (String? newValue) {
                                    setState(() {
                                      ageValue = newValue!.toString();
                                      _isChange = true;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InputField(
                                  controller: zipCodeValue,
                                  textInputAction: TextInputAction.go,
                                  keyboardType: TextInputType.text,
                                  hintText: "ZIP Code / Postal Code",
                                  obscureText: false,
                                  suffix: zipRequestSend,
                                  onchanged: (value) async {
                                    setState(() {
                                      zipRequestSend = true;
                                    });
                                    var url =
                                        "${ApiUrls().zipcodes}$countryValue?zip=${zipCodeValue.text}";
                                    var response = await Dio().get(url);
                                    if (response.statusCode == 200) {
                                      if (response.data["success"]) {
                                        setState(() {
                                          zipRequestSend = false;
                                          // postalCodeValidate = true;
                                          _isChange = true;
                                        });
                                      } else if (!response.data["success"]) {
                                        setState(() {
                                          // postalCodeValidate = false;
                                          _isChange = false;
                                          zipRequestSend = false;
                                        });
                                      }
                                    } else {
                                      scaffoldMessenger.showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Server is busy. Try again later",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter Postal / ZIP code";
                                    } else if (!postalCodeValidate) {
                                      return "Invalid Postal / ZIP code";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: AutoSizeText(
                                    "Categories",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.green,
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: bussnessCategory?.length,
                                    itemBuilder: (context, index) {
                                      var select = false;
                                      if (selectedList
                                          .contains(itemList[index]["id"])) {
                                        select = true;
                                      }
                                      return ListItems(
                                        item: bussnessCategory![index],
                                        selected: select,
                                        isSelected: (bool value) {
                                          setState(() {
                                            _isChange = true;
                                            if (value) {
                                              var val = itemList[index]["id"];
                                              selectedList.add(val);
                                            } else {
                                              selectedList.remove(
                                                  itemList[index]["id"]);
                                            }
                                          });
                                        },
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
