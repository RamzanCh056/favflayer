// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:ffadvertisement/utils/api_url.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:ffadvertisement/component/input_field.dart';
import 'package:ffadvertisement/component/my_app_bar.dart';
import 'package:ffadvertisement/utils/storage_service.dart';
import 'package:flutter/material.dart';

class ManageAccount extends StatefulWidget {
  const ManageAccount({
    Key? key,
  }) : super(key: key);

  @override
  State<ManageAccount> createState() => _ManageAccountState();
}

class _ManageAccountState extends State<ManageAccount> {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();
  bool nameIsChange = false;
  bool nameRequestSend = false;
  bool passRequestSend = false;
  bool passIsEnter = false;
  final _changePasswordKey = GlobalKey<FormState>();
  String? name;
  late ScaffoldMessengerState scaffoldMessenger;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    name = await StorageService().readSecureData("user_name");
    setState(() {
      userName.text = name.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: const MyAppBar(),
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 0),
                  leading: Image.asset(
                    "assets/ios-user-setting.png",
                    width: 25,
                    height: 25,
                  ),
                  title: const AutoSizeText(
                    "Manage Account",
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
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 0),
                  leading: Image.asset(
                    "assets/ios-user-edit.png",
                    width: 25,
                    height: 25,
                  ),
                  title: const AutoSizeText(
                    "Change Name",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: nameIsChange
                      ? InkWell(
                          onTap: () async {
                            if (userName.text.isNotEmpty &&
                                userName.text.toString() != name) {
                              setState(() {
                                nameRequestSend = true;
                              });
                              var nameRes = await Dio().post(
                                ApiUrls().change_name.toString(),
                                data: {
                                  "id": await StorageService()
                                      .readSecureData("user_id"),
                                  "name": userName.text.toString()
                                },
                              );
                              if (nameRes.data["success"]) {
                                scaffoldMessenger.showSnackBar(
                                  const SnackBar(
                                    content: Text("Name Is Update"),
                                  ),
                                );
                                StorageService().writeSecureData(StorageItem(
                                    "user_name", userName.text.toString()));
                                setState(() {
                                  name = userName.text.toString();
                                  nameIsChange = false;
                                  nameRequestSend = false;
                                });
                              } else {
                                scaffoldMessenger.showSnackBar(
                                  const SnackBar(
                                    content: Text("Name Is Not Update"),
                                  ),
                                );
                                setState(() {
                                  nameRequestSend = false;
                                });
                              }
                              // print(nameRes);
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.zero,
                            child: Icon(
                              Icons.check_circle,
                              size: 28,
                            ),
                          ),
                        )
                      : nameRequestSend
                          ? Container(
                              height: 20,
                              width: 20,
                              child: const CircularProgressIndicator(
                                color: Color(0xFF6AA71A),
                              ),
                            )
                          : null,
                  minLeadingWidth: 20,
                  iconColor: const Color(0xFF6AA71A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(05),
                  ),
                ),
                TextField(
                  controller: userName,
                  cursorColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  onChanged: (vlaue) {
                    setState(() {
                      nameIsChange = true;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    hintText: 'User Name',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    filled: true,
                    fillColor: Color(0xFF292839),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 0),
                  leading: Image.asset(
                    "assets/ios-awesome-key.png",
                    width: 25,
                    height: 25,
                  ),
                  title: const AutoSizeText(
                    "Change Password",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: passIsEnter
                      ? InkWell(
                          onTap: () async {
                            if (_changePasswordKey.currentState!.validate()) {
                              setState(() {
                                passRequestSend = true;
                              });
                              var changePassRes = await Dio().post(
                                ApiUrls().change_password.toString(),
                                data: {
                                  "id": await StorageService()
                                      .readSecureData("user_id"),
                                  "password": password.text.toString(),
                                  "new_password": newPassword.text.toString(),
                                },
                              );
                              if (changePassRes.data["success"]) {
                                setState(() {
                                  passRequestSend = false;
                                });
                                scaffoldMessenger.showSnackBar(
                                  const SnackBar(
                                    content: Text("Password Is Change"),
                                  ),
                                );

                                password.clear();
                                confirmNewPassword.clear();
                                newPassword.clear();
                              } else {
                                setState(() {
                                  passRequestSend = false;
                                });
                                scaffoldMessenger.showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "${changePassRes.data['message']}"),
                                  ),
                                );
                              }
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.zero,
                            child: Icon(
                              Icons.check_circle,
                              size: 28,
                            ),
                          ),
                        )
                      : passRequestSend
                          ? Container(
                              height: 20,
                              width: 20,
                              child: const CircularProgressIndicator(
                                color: Color(0xFF6AA71A),
                              ),
                            )
                          : null,
                  minLeadingWidth: 20,
                  visualDensity:
                      const VisualDensity(horizontal: -0, vertical: 00),
                  iconColor: const Color(0xFF6AA71A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(05),
                  ),
                ),
                Form(
                  key: _changePasswordKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      InputField(
                        controller: password,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: "Current Password",
                        obscureText: true,
                        suffix: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Current Password';
                          } else if (value.length < 8) {
                            return 'Please Enter Correct Password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputField(
                        controller: newPassword,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: "New Password",
                        obscureText: true,
                        suffix: false,
                        onchanged: (val) {
                          if (val.isNotEmpty &&
                              confirmNewPassword.text == val) {
                            setState(() {
                              passIsEnter = true;
                            });
                          } else {
                            setState(() {
                              passIsEnter = false;
                            });
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter New Password';
                          } else if (value.length < 8) {
                            return 'Password must have a minimum Length of 8 Characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputField(
                        controller: confirmNewPassword,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: "verify New Password",
                        obscureText: true,
                        suffix: false,
                        onchanged: (val) {
                          if (newPassword.text.isNotEmpty &&
                              password.text.isNotEmpty &&
                              newPassword.text == val) {
                            setState(() {
                              passIsEnter = true;
                            });
                          } else {
                            setState(() {
                              passIsEnter = false;
                            });
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Again New Password';
                          } else if (value.length < 8) {
                            return 'Password must have a minimum Length of 8 Characters';
                          } else if (value != newPassword.text) {
                            return 'Password Dose Not Match';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
