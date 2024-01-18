// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, use_build_context_synchronously

import 'dart:collection';

import 'package:ffadvertisement/utils/api_url.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:ffadvertisement/component/button.dart';
import 'package:ffadvertisement/component/input_field.dart';
import 'package:ffadvertisement/utils/storage_service.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginEmailTextEditor = TextEditingController();
  final _loginPassTextEditor = TextEditingController();
  final storageService = StorageService();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _validateEmail = false;
  bool _passwordValid = true;
  Map<String, String> req = HashMap();
  late ScaffoldMessengerState scaffoldMessenger;



  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Image.asset(
                    "assets/logo.png",
                    height: 100,
                    width: MediaQuery.of(context).size.width - 150,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        "Login to your Account",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputField(
                        controller: _loginEmailTextEditor,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        hintText: "Email",
                        obscureText: false,
                        suffix: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter email";
                          } else if (!value.contains("@")) {
                            return "Please enter a correct email";
                          } else if (_validateEmail) {
                            return "Email is not exist!";
                          }
                          return null;
                        },
                      ),
                      // InputField(),
                      const SizedBox(
                        height: 20,
                      ),
                      InputField(
                        controller: _loginPassTextEditor,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: "Password",
                        obscureText: true,
                        suffix: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Password";
                          } else if (_passwordValid) {
                            return "Wrong Password";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Button(
                        onPressed: () async {
                          Response res = await Dio().post(
                              ApiUrls().email.toString(),
                              data: {"email": _loginEmailTextEditor.text});
                          if (res.statusCode == 200) {
                            if (res.data["success"]) {
                              setState(() {
                                _validateEmail = false;
                              });
                            } else if (!res.data["success"]) {
                              setState(() {
                                _validateEmail = true;
                              });
                            }
                            _formKey.currentState!.validate();
                          } else {
                            scaffoldMessenger.showSnackBar(
                              SnackBar(
                                content: Text("${res.statusMessage}"),
                              ),
                            );
                          }
                          setState(() {
                            _passwordValid = false;
                          });
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            req.addAll({
                              "email": _loginEmailTextEditor.text,
                              "password": _loginPassTextEditor.text,
                            });
                            final response = await Dio().post(
                              ApiUrls().login.toString(),
                              data: req,
                            );
                            if (response.statusCode == 200) {
                              if (response.data["success"]) {
                                storageService.writeSecureData(
                                  StorageItem(
                                    "user_id",
                                    response.data["data"]["token"]
                                            ["tokenable_id"]
                                        .toString(),
                                  ),
                                );
                                storageService.writeSecureData(
                                  StorageItem(
                                    "user_name",
                                    response.data["data"]["name"].toString(),
                                  ),
                                );
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/home',
                                );
                              } else if (!response.data["success"]) {
                                setState(() {
                                  _passwordValid = true;
                                  _formKey.currentState!.validate();
                                  _isLoading = false;
                                });
                              }
                            } else {
                              scaffoldMessenger.showSnackBar(
                                SnackBar(
                                  content: Text("${response.statusMessage}"),
                                ),
                              );
                            }
                            setState(() {
                              _isLoading = false;
                            });
                          }
                          setState(() {
                            _isLoading = false;
                          });
                        },
                        title: !_isLoading
                            ? const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              )
                            : const CircularProgressIndicator(),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AutoSizeText(
                      "Not on FavoriteFlyer yet!",
                      style: TextStyle(color: Colors.white),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/signup");
                      },
                      child: const AutoSizeText(
                        " Sign up",
                        style: TextStyle(
                          color: Color(0xFF6AA71A),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
