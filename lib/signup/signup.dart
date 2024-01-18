// ignore_for_file: sized_box_for_whitespace, non_constant_identifier_names, use_build_context_synchronously

import 'package:ffadvertisement/utils/api_url.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:ffadvertisement/component/button.dart';
import 'package:ffadvertisement/component/input_field.dart';
import 'package:ffadvertisement/signup/signup_model.dart';
import 'package:ffadvertisement/signup/welcomeScreen.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final signUpUserTextEditor = TextEditingController();
  final signUpEmailTextEditor = TextEditingController();
  final signUpPassTextEditor = TextEditingController();
  final signUpConfirmPassTextEditor = TextEditingController();
  final _signUpFormKey = GlobalKey<FormState>();
  bool validateEmail = true;
  bool emailSend = false;
  late ScaffoldMessengerState scaffoldMessenger;

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/logo.png",
                      height: 100,
                      width: MediaQuery.of(context).size.width - 150,
                    ),
                  ),
                  Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        const AutoSizeText(
                          "Create your Account",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InputField(
                          controller: signUpUserTextEditor,
                          hintText: "Name",
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          obscureText: false,
                          suffix: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter User Name";
                            } else if (value.length < 2) {
                              return "User Name must have a minimum Length of 2 Characters";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InputField(
                          controller: signUpEmailTextEditor,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          hintText: "Email",
                          suffix: emailSend,
                          obscureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter email";
                            } else if (!value.contains("@")) {
                              return "Please enter a correct email";
                            } else if (!validateEmail) {
                              return "Email already exist!";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InputField(
                          controller: signUpPassTextEditor,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          hintText: "Password",
                          obscureText: true,
                          suffix: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter password";
                            } else if (value.length < 8) {
                              return "Password must have a minimum Length of 8 characters";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InputField(
                          controller: signUpConfirmPassTextEditor,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          hintText: "Confirm Password",
                          obscureText: true,
                          suffix: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Password";
                            } else if (value != signUpPassTextEditor.text) {
                            } else if (value != signUpPassTextEditor.text) {
                              return "Password Does Not Match";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Button(
                          onPressed: () async {
                            setState(() {
                              emailSend = true;
                            });
                            Response valEmailRes = await Dio().post(
                              ApiUrls().email.toString(),
                              data: {"email": signUpEmailTextEditor.text},
                            );

                            if (valEmailRes.statusCode == 200) {
                              if (valEmailRes.data["success"]) {
                                setState(() {
                                  validateEmail = false;
                                });
                              } else if (!valEmailRes.data["success"]) {
                                setState(() {
                                  validateEmail = true;
                                });
                              }
                              setState(() {
                                emailSend = false;
                              });
                              _signUpFormKey.currentState!.validate();
                            } else {
                              scaffoldMessenger.showSnackBar(
                                SnackBar(
                                  content: Text("${valEmailRes.statusMessage}"),
                                ),
                              );
                            }

                            if (_signUpFormKey.currentState!.validate()) {
                              var data = SignUpModel(
                                email: signUpEmailTextEditor.text,
                                password: signUpPassTextEditor.text,
                                uName: signUpUserTextEditor.text,
                              ).toJson();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      WelcomeScreen(data: data),
                                ),
                              );
                            }
                          },
                          title: !emailSend
                              ? const Text(
                                  "Sign up",
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
                        "Already a member?",
                        style: TextStyle(color: Colors.white),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: const AutoSizeText(
                          " Log in",
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
      ),
    );
  }
}
