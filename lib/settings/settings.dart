import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffadvertisement/component/my_app_bar.dart';
import 'package:ffadvertisement/component/my_list_tile.dart';
import 'package:ffadvertisement/main.dart';
import 'package:ffadvertisement/utils/api_url.dart';
import 'package:ffadvertisement/utils/storage_service.dart';
import 'package:ffadvertisement/settings/about.dart';
import 'package:ffadvertisement/settings/general_setting.dart';
import 'package:ffadvertisement/settings/manage_account.dart';
import 'package:ffadvertisement/settings/privacy.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../onboarding/screen/information_geth.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  dynamic userId;
  late ScaffoldMessengerState scaffoldMessenger;
  final storageService = StorageService();
  
  @override
  void initState() {
    super.initState();
    printSharedPreferencesData();
    getUserData();
  }
  String? fcmToken;


  void printSharedPreferencesData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    fcmToken = prefs.getString('fcmToken') ?? 'N/A';
    print('token: $fcmToken');

  }
  void getUserData() async {
    var getUserId = await storageService.readSecureData("user_id");
    setState(() {
      userId = getUserId;
    });
  }
  Future<void> deleteCollection(String collectionName) async {
    final CollectionReference collectionRef = FirebaseFirestore.instance.collection(collectionName);
    final QuerySnapshot querySnapshot = await collectionRef.get();

    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      await documentSnapshot.reference.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text("Settings"),
      ),
      //const MyAppBar(),
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(

                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff4D4C51),),
                    color: const Color(0xFF292839),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Row(children: [
                            const SizedBox(width: 5,),
                            Image.asset(
                              "assets/ios-settings.png",
                              width: 25,
                              height: 25,
                            ),
                            const SizedBox(width: 20,),
                            const AutoSizeText(
                              "General Settings",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Expanded(child: SizedBox(width: 2,)),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>  InformationGethring(zipCode: 'Enter Zip code', country: "Select Country",),
                                  ),
                                );
                              },
                                child: const Icon(Icons.arrow_forward_ios, color: Color(0xFF6AA71A),)),
                            SizedBox(width: 5,),
                          ],)


                        ],),
                    ),
                  ),


                ),
                const SizedBox(height: 15,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutUs(),
                      ),
                    );
                  },
                  child: Container(

                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff4D4C51),),
                      color: const Color(0xFF292839),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                          Row(children: [
                            const SizedBox(width: 5,),
                            Image.asset(
                              "assets/ios-about.png",
                              width: 25,
                              height: 25,
                            ),
                            const SizedBox(width: 20,),
                            const AutoSizeText(
                              "About",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],)


                        ],),
                      ),
                    ),


                  ),
                ),
                const SizedBox(height: 15,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Privacy(),
                      ),
                    );
                  },
                  child: Container(

                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff4D4C51),),
                      color: const Color(0xFF292839),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Row(children: [
                              const SizedBox(width: 5,),
                              Image.asset(
                                "assets/ios-privacy.png",
                                width: 25,
                                height: 25,
                              ),
                              const SizedBox(width: 20,),
                              const AutoSizeText(
                                "Privacy Policy",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],)


                          ],),
                      ),
                    ),


                  ),
                ),
                const SizedBox(height: 15,),
                GestureDetector(
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: const Color(0xFF292839),
                        titleTextStyle: const TextStyle(color: Colors.white),
                        contentTextStyle: const TextStyle(color: Colors.white),
                        title: const Text("Logout"),
                        content:
                        const Text("Are you sure you want to log out?"),
                        actions: [
                          TextButton(
                            style: ButtonStyle(shape:
                            MaterialStateProperty.resolveWith((states) {
                              return RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(04),
                                  side: const BorderSide(color: Colors.green));
                            })),
                            onPressed: ()async  {
                              StorageService().deleteSecureData("user_id");
                              StorageService().deleteSecureData("user_name");
                               await deleteSharedPreferencesData();
                              await deleteCollection(fcmToken.toString());

                            
                            
                            
                              RestartApp.restart(context);
                            },
                            child: const Text(
                              "Yes",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          TextButton(
                            style: ButtonStyle(shape:
                            MaterialStateProperty.resolveWith((states) {
                              return RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(04),
                                  side: const BorderSide(color: Colors.green));
                            })),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "No",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  child: Container(

                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff4D4C51),),
                      color: const Color(0xFF292839),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Row(children: [
                              const SizedBox(width: 5,),
                              Image.asset(
                                "assets/logout.png",
                                width: 25,
                                height: 25,
                              ),
                              const SizedBox(width: 20,),
                              const AutoSizeText(
                                "Log Out",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],)


                          ],),
                      ),
                    ),


                  ),
                ),
                // const SizedBox(height: 15,),
                // MyListTile(
                //   title: "Manage Account",
                //   imageSrc: "assets/ios-user.png",
                //   onTap: () => Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const ManageAccount(),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // MyListTile(
                //   title: "General Settings",
                //   imageSrc: "assets/ios-user.png",
                //   onTap: () => Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const GeneralSetting(),
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 10,
                ),
                // MyListTile(
                //   title: "About",
                //   imageSrc: "assets/ios-about.png",
                //   onTap: () => Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const AboutUs(),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // MyListTile(
                //   title: "Privacy Policy",
                //   imageSrc: "assets/ios-privacy.png",
                //   onTap: () => Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const Privacy(),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // MyListTile(
                //   title: "Deactivate Account",
                //   imageSrc: "assets/deactivate-account.png",
                //   onTap: () {
                //     showDialog(
                //       context: context,
                //       builder: (context) => AlertDialog(
                //         backgroundColor: const Color(0xFF292839),
                //         titleTextStyle: const TextStyle(color: Colors.white),
                //         contentTextStyle: const TextStyle(color: Colors.white),
                //         title: const Text("Deactivate Account"),
                //         content: const Text(
                //             "Are you sure to Deactivate your Account?"),
                //         actions: [
                //           TextButton(
                //             style: ButtonStyle(shape:
                //                 MaterialStateProperty.resolveWith((states) {
                //               return RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(04),
                //                   side: const BorderSide(color: Colors.green));
                //             })),
                //             onPressed: () {
                //               var request = Dio()
                //                   .get("${ApiUrls().activateApi}$userId")
                //                   .then((resp) {
                //                 if (resp.data['success']) {
                //                   StorageService().deleteSecureData("user_id");
                //                   StorageService()
                //                       .deleteSecureData("user_name");
                //                   RestartApp.restart(context);
                //                 } else {
                //                   scaffoldMessenger.showSnackBar(const SnackBar(
                //                       content: Text(
                //                     "Please try again later",
                //                     style: TextStyle(color: Colors.white),
                //                   )));
                //                   Navigator.of(context).pop();
                //                 }
                //               }).catchError((onError) {
                //                 scaffoldMessenger.showSnackBar(SnackBar(
                //                     content: Text(
                //                   onError.toString(),
                //                   style: const TextStyle(color: Colors.white),
                //                 )));
                //                 Navigator.of(context).pop();
                //               });
                //             },
                //             child: const Text(
                //               "Yes",
                //               style: TextStyle(color: Colors.white),
                //             ),
                //           ),
                //           TextButton(
                //             style: ButtonStyle(shape:
                //                 MaterialStateProperty.resolveWith((states) {
                //               return RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(04),
                //                   side: const BorderSide(color: Colors.green));
                //             })),
                //             onPressed: () {
                //               Navigator.of(context).pop();
                //             },
                //             child: const Text(
                //               "No",
                //               style: TextStyle(color: Colors.white),
                //             ),
                //           )
                //         ],
                //       ),
                //     );
                //   },
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // MyListTile(
                //   title: "Log Out",
                //   imageSrc: "assets/logout.png",
                //   onTap: () {
                //     showDialog(
                //       context: context,
                //       builder: (context) => AlertDialog(
                //         backgroundColor: const Color(0xFF292839),
                //         titleTextStyle: const TextStyle(color: Colors.white),
                //         contentTextStyle: const TextStyle(color: Colors.white),
                //         title: const Text("Logout"),
                //         content:
                //             const Text("Are you sure you want to log out?"),
                //         actions: [
                //           TextButton(
                //             style: ButtonStyle(shape:
                //                 MaterialStateProperty.resolveWith((states) {
                //               return RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(04),
                //                   side: const BorderSide(color: Colors.green));
                //             })),
                //             onPressed: () {
                //               StorageService().deleteSecureData("user_id");
                //               StorageService().deleteSecureData("user_name");
                //               RestartApp.restart(context);
                //             },
                //             child: const Text(
                //               "Yes",
                //               style: TextStyle(color: Colors.white),
                //             ),
                //           ),
                //           TextButton(
                //             style: ButtonStyle(shape:
                //                 MaterialStateProperty.resolveWith((states) {
                //               return RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(04),
                //                   side: const BorderSide(color: Colors.green));
                //             })),
                //             onPressed: () {
                //               Navigator.of(context).pop();
                //             },
                //             child: const Text(
                //               "No",
                //               style: TextStyle(color: Colors.white),
                //             ),
                //           )
                //         ],
                //       ),
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> deleteSharedPreferencesData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // List of keys to delete
  List<String> keysToDelete = ['name', 'zipCode', 'age', 'country', 'gender'];

  // Delete each key from SharedPreferences
  for (String key in keysToDelete) {
    prefs.remove(key);
  }
}
}
