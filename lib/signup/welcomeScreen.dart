// ignore_for_file: avoid_unnecessary_containers, file_names, prefer_typing_uninitialized_variables, avoid_types_as_parameter_names, non_constant_identifier_names, unused_import, library_private_types_in_public_api, unused_local_variable, import_of_legacy_library_into_null_safe

import 'dart:collection';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dio/dio.dart';
import 'package:ffadvertisement/component/button.dart';
import 'package:ffadvertisement/component/circle_progress_indicator.dart';
import 'package:ffadvertisement/component/input_field.dart';
import 'package:ffadvertisement/component/listitems.dart';
import 'package:ffadvertisement/component/my_drop_down.dart';
import 'package:ffadvertisement/utils/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_html/flutter_html.dart';
import '../utils/api_url.dart';

class WelcomeScreen extends StatefulWidget {
  final data;

  const WelcomeScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  final storageService = StorageService();
  int currentIndex = 0;
  late TabController _tabC;
  String genderValue = "1";
  var ageValue = "1";
  String countryValue = "US";
  TextEditingController zipCodeValue = TextEditingController();
  List<dynamic>? bussnessCategory;
  List itemList = [];
  List selectedList = [];
  Map<String, String> req = HashMap();
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
  final _thirdFormKey = GlobalKey<FormState>();
  late final userName;
  late final userEmail;
  late final userPass;
  bool postalCodeValidate = false;
  bool requestSend = false;
  bool _isFinishLoading = false;
  bool isLoading = true;
  bool isPrivacyCheck = true;
  late ScaffoldMessengerState scaffoldMessenger;
  String contentText = '';
  @override
  void initState() {
    super.initState();
    _tabC = TabController(length: 5, vsync: this, initialIndex: 0);
    userName = widget.data['userName'].toString();
    userEmail = widget.data['email'].toString();
    userPass = widget.data['password'].toString();
    var response = Dio().get(ApiUrls().buisness_categories.toString());
    response.then((value) {
      if (value.data.isNotEmpty) {
        setState(() {
          isLoading = false;
          bussnessCategory = value.data;
          itemList = value.data;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
    var privacyText = Dio().get(ApiUrls().privacy.toString());

    privacyText.then((res) {
      if (res.data.isNotEmpty) {
        setState(() {
          contentText = res.data["description"].toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return isLoading
        ? const Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                backgroundColor: Color(0xFF6AA71A),
              ),
            ),
          )
        : DefaultTabController(
            length: 5,
            child: Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              appBar: AppBar(
                elevation: 0,
                shadowColor: Colors.transparent,
                backgroundColor: Theme.of(context).primaryColor,
                leading: _tabC.index > 0
                    ? IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _tabC.animateTo((_tabC.index - 1) % 5);
                          setState(() {
                            _tabC.index;
                          });
                        },
                      )
                    : Container(),
                bottom: PreferredSize(
                  preferredSize:
                      Size.fromHeight(MediaQuery.of(context).padding.top),
                  child: IgnorePointer(
                    ignoring: true,
                    child: TabBar(
                      physics: const NeverScrollableScrollPhysics(),
                      // indicatorWeight: 0,
                      indicatorColor: Colors.transparent,
                      controller: _tabC,
                      isScrollable: true,
                      padding: EdgeInsets.zero,
                      indicatorPadding: EdgeInsets.zero,
                      labelPadding: EdgeInsets.zero,
                      tabs: [
                        Tab(
                          iconMargin: const EdgeInsets.only(bottom: 0),
                          child: _tabC.index == 0
                              ? const CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Color(0xFF6AA71A),
                                  child: CircleAvatar(
                                    radius: 11.5,
                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Color(0xFF6AA71A),
                                    ),
                                  ),
                                )
                              : const Icon(
                                  Icons.circle,
                                  size: 18,
                                  color: Color(0xFF6AA71A),
                                ),
                        ),
                        Tab(
                          iconMargin: const EdgeInsets.only(bottom: 0),
                          child: _tabC.index == 1
                              ? const CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Color(0xFF6AA71A),
                                  child: CircleAvatar(
                                    radius: 11.5,
                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Color(0xFF6AA71A),
                                    ),
                                  ),
                                )
                              : const Icon(
                                  Icons.circle,
                                  size: 18,
                                  color: Color(0xFF6AA71A),
                                ),
                        ),
                        Tab(
                          iconMargin: const EdgeInsets.only(bottom: 0),
                          child: _tabC.index == 2
                              ? const CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Color(0xFF6AA71A),
                                  child: CircleAvatar(
                                    radius: 11.5,
                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Color(0xFF6AA71A),
                                    ),
                                  ),
                                )
                              : const Icon(
                                  Icons.circle,
                                  size: 18,
                                  color: Color(0xFF6AA71A),
                                ),
                        ),
                        Tab(
                          iconMargin: const EdgeInsets.only(bottom: 0),
                          child: _tabC.index == 3
                              ? const CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Color(0xFF6AA71A),
                                  child: CircleAvatar(
                                    radius: 11.5,
                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Color(0xFF6AA71A),
                                    ),
                                  ),
                                )
                              : const Icon(
                                  Icons.circle,
                                  size: 18,
                                  color: Color(0xFF6AA71A),
                                ),
                        ),
                        Tab(
                          iconMargin: const EdgeInsets.only(bottom: 0),
                          child: _tabC.index == 4
                              ? const CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Color(0xFF6AA71A),
                                  child: CircleAvatar(
                                    radius: 11.5,
                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Color(0xFF6AA71A),
                                    ),
                                  ),
                                )
                              : const Icon(
                                  Icons.circle,
                                  size: 18,
                                  color: Color(0xFF6AA71A),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabC,
                children: [
                  Center(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 85,
                              backgroundColor: const Color(0xFF6AA71A),
                              child: CircleAvatar(
                                radius: 83,
                                child: CircleAvatar(
                                  radius: 80,
                                  backgroundColor: const Color(0xFF6AA71A),
                                  child: Text(
                                    userName[0].toString().toUpperCase(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 120,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            AutoSizeText(
                              userEmail,
                              style: const TextStyle(color: Colors.white),
                              maxLines: 1,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const AutoSizeText(
                              "Welcome to FavoriteFlyer",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              maxLines: 1,
                              softWrap: true,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            AutoSizeText(
                              userName,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                              maxLines: 1,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const AutoSizeText(
                              "Your answer to the next few questions will help us to get you valuable coupons and promotions from your favorite brands.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              maxLines: 3,
                              softWrap: true,
                            ),
                            const SizedBox(
                              height: 45,
                            ),
                            Button(
                              onPressed: () {
                                _tabC.animateTo((_tabC.index + 1) % 5);
                                setState(() {
                                  _tabC.index;
                                });
                              },
                              title: const AutoSizeText(
                                "Next",
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                                maxLines: 1,
                              ),
                              padding: const EdgeInsets.all(16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 60,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            const AutoSizeText(
                              "Select your Gender & Age",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              maxLines: 1,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const AutoSizeText(
                              "How you identify. And your age range ensures you get valuable coupons and promotions that matter to you.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                              maxLines: 3,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            MyDropDown(
                              label: "Gender",
                              optionsList: gender,
                              optionsName: genderName,
                              value: genderValue,
                              oncange: (String? newValue) {
                                setState(() {
                                  genderValue = newValue!;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            MyDropDown(
                              label: "Age",
                              optionsList: age,
                              optionsName: ageRange,
                              value: ageValue,
                              oncange: (String? newValue) {
                                setState(() {
                                  ageValue = newValue!.toString();
                                });
                              },
                            ),
                            const SizedBox(
                              height: 45,
                            ),
                            Button(
                              onPressed: () {
                                _tabC.animateTo((_tabC.index + 1) % 5);
                                setState(() {
                                  _tabC.index;
                                });
                              },
                              title: const AutoSizeText(
                                "Next",
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                                maxLines: 1,
                              ),
                              padding: const EdgeInsets.all(16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(40),
                        child: Form(
                          key: _thirdFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 25,
                              ),
                              const AutoSizeText(
                                "Select your Country & Zip",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                                maxLines: 1,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              const AutoSizeText(
                                "Your postal or zip code is how we get valuable coupons and promotions relevant to you. Feel safe using Favorite Flyer. We promise to never track you while using our app.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                                maxLines: 3,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF292839),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(05)),
                                ),
                                child: CountryCodePicker(
                                  alignLeft: true,
                                  padding: const EdgeInsets.all(0),
                                  backgroundColor: Colors.white,
                                  barrierColor: Colors.white,
                                  showFlag: true,
                                  textStyle:
                                      const TextStyle(color: Colors.white),
                                  initialSelection: countryValue,
                                  enabled: true,
                                  showOnlyCountryWhenClosed: true,
                                  showCountryOnly: true,
                                  showFlagMain: true,
                                  showDropDownButton: true,
                                  onChanged: (value) {
                                    setState(() {
                                      countryValue = value.code!;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InputField(
                                controller: zipCodeValue,
                                textInputAction: TextInputAction.go,
                                keyboardType: TextInputType.text,
                                hintText: "ZIP Code / Postal Code",
                                obscureText: false,
                                suffix: requestSend,
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
                                height: 45,
                              ),
                              Button(
                                onPressed: () async {
                                  setState(() {
                                    requestSend = true;
                                  });
                                  var url =
                                      "${ApiUrls().zipcodes}$countryValue?zip=${zipCodeValue.text}";
                                  var response = await Dio().get(url);
                                  if (response.statusCode == 200) {
                                    if (response.data["success"]) {
                                      setState(() {
                                        requestSend = false;
                                        postalCodeValidate = true;
                                      });
                                    } else if (!response.data["success"]) {
                                      setState(() {
                                        postalCodeValidate = false;
                                        requestSend = false;
                                      });
                                    }
                                  } else {
                                    scaffoldMessenger.showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Server is busy. Try again later",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    );
                                  }
                                  if (_thirdFormKey.currentState!.validate()) {
                                    _tabC.animateTo((_tabC.index + 1) % 5);
                                    setState(() {
                                      _tabC.index;
                                    });
                                  }
                                },
                                title: const AutoSizeText(
                                  "Next",
                                  style: TextStyle(
                                    fontSize: 24,
                                  ),
                                  maxLines: 1,
                                ),
                                padding: const EdgeInsets.all(16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Container(
                            color: Theme.of(context).primaryColor,
                            alignment: Alignment.center,
                            child: const AutoSizeText(
                              "Tell us what you're interested in",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          fit: FlexFit.tight,
                          child: ListView.builder(
                            itemCount: bussnessCategory?.length,
                            itemBuilder: (BuildContext, index) {
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
                                    if (value) {
                                      var val = itemList[index]["id"];
                                      selectedList.add(val);
                                    } else {
                                      selectedList
                                          .remove(itemList[index]["id"]);
                                    }
                                  });
                                },
                              );
                            },
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: Container(
                            color: Theme.of(context).primaryColor,
                            alignment: Alignment.topCenter,
                            padding: const EdgeInsets.only(top: 5),
                            child: Button(
                              title: !_isFinishLoading
                                  ? const Text(
                                      "Next",
                                      style: TextStyle(
                                        fontSize: 24,
                                      ),
                                    )
                                  : const CircleProgressIndicator(),
                              onPressed: () {
                                if (selectedList.isNotEmpty) {
                                  _tabC.animateTo((_tabC.index + 1) % 5);
                                  setState(() {
                                    _tabC.index;
                                  });
                                } else {
                                  scaffoldMessenger.showSnackBar(const SnackBar(
                                      content:
                                          Text("Please select categories")));
                                }
                              },
                              padding: const EdgeInsets.all(16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: Column(
                      children: [
                        Flexible(
                          flex: 5,
                          fit: FlexFit.tight,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "Privacy Policy",
                                  style: TextStyle(
                                      color: Color(0xffffffff), fontSize: 20),
                                ),
                                // HtmlWidget(content.data.description),
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
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Container(
                            color: Theme.of(context).primaryColor,
                            alignment: Alignment.center,
                            child: CheckboxListTile(
                              value: timeDilation != 0.5,
                              onChanged: (bool? value) {
                                setState(() {
                                  timeDilation = value! ? 1.0 : 0.5;
                                });
                                if (value!) {
                                  setState(() {
                                    isPrivacyCheck = true;
                                  });
                                } else {
                                  setState(() {
                                    isPrivacyCheck = false;
                                  });
                                }
                              },
                              controlAffinity: ListTileControlAffinity.trailing,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              visualDensity: VisualDensity.compact,
                              checkboxShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(02)),
                              activeColor: const Color(0xFF6AA71A),
                              title: const AutoSizeText(
                                "Agree privacy policy",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: Container(
                            color: Theme.of(context).primaryColor,
                            alignment: Alignment.topCenter,
                            padding: const EdgeInsets.only(top: 5),
                            child: Button(
                              title: !_isFinishLoading
                                  ? const Text(
                                      "Finish",
                                      style: TextStyle(
                                        fontSize: 24,
                                      ),
                                    )
                                  : const CircularProgressIndicator(),
                              onPressed: () {
                                if (isPrivacyCheck) {
                                  req.addAll({
                                    "name": userName,
                                    "email": userEmail,
                                    "password": userPass,
                                    "gender": genderValue,
                                    "age": ageValue.toString(),
                                    "zip_code": zipCodeValue.text,
                                    "buisness_category":
                                        jsonEncode(selectedList),
                                    "country": countryValue,
                                  });
                                  setState(() {
                                    _isFinishLoading = true;
                                  });
                                  var response = Dio()
                                      .post(
                                    ApiUrls().registration.toString(),
                                    data: req,
                                  )
                                      .then((value) {
                                    if (value.data["success"]) {
                                      storageService.writeSecureData(
                                        StorageItem(
                                          "user_id",
                                          value.data["data"]["token"]
                                                  ["tokenable_id"]
                                              .toString(),
                                        ),
                                      );
                                      storageService.writeSecureData(
                                        StorageItem(
                                          "user_name",
                                          value.data["data"]["name"].toString(),
                                        ),
                                      );
                                      setState(() {
                                        _isFinishLoading = false;
                                      });
                                      Navigator.pushReplacementNamed(
                                        context,
                                        '/home',
                                      );
                                    } else {
                                      setState(() {
                                        _isFinishLoading = false;
                                      });
                                      scaffoldMessenger.showSnackBar(SnackBar(
                                          content: Text(
                                              "${value.data['message']}")));
                                    }
                                  }).catchError((onError) {
                                    setState(() {
                                      _isFinishLoading = false;
                                    });

                                    scaffoldMessenger.showSnackBar(SnackBar(
                                      content: Text("$onError"),
                                    ));
                                  });
                                } else {
                                  scaffoldMessenger.showSnackBar(const SnackBar(
                                    content:
                                        Text("Please agree privacy policy"),
                                  ));
                                }
                              },
                              padding: !_isFinishLoading
                                  ? const EdgeInsets.all(16)
                                  : const EdgeInsets.all(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
