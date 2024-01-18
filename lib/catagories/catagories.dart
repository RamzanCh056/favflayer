//
//
// import 'dart:convert';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ffadvertisement/component/circle_progress_indicator.dart';
// import 'package:ffadvertisement/component/no_data_text.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import '../component/my_app_bar.dart';
// import '../onboarding/consts/reusable_text.dart';
// import '../onboarding/utils/app_color.dart';
//
// class CategoriesList extends StatefulWidget {
//   const CategoriesList({Key? key}) : super(key: key);
//
//   @override
//   State<CategoriesList> createState() => _CategoriesListState();
// }
//
// class _CategoriesListState extends State<CategoriesList> {
//   // List of images
//   List<String> images = [
//     "images/jason.jpg",
//     "images/edward.jpg",
//     "images/ashkan.jpg",
//     "images/peter.jpg",
//     "images/rachel.jpg",
//     "images/senjuti.jpg",
//     "images/ashkan.jpg",
//     "images/edward.jpg",
//     "images/jason.jpg",
//     "images/peter.jpg",
//     "images/rachel.jpg",
//     "images/senjuti.jpg",
//     "images/ashkan.jpg",
//     "images/edward.jpg",
//     "images/jason.jpg",
//     "images/peter.jpg",
//     "images/rachel.jpg",
//     "images/senjuti.jpg",
//     "images/jason.jpg",
//     "images/peter.jpg",
//     "images/rachel.jpg",
//     "images/senjuti.jpg",
//     "images/peter.jpg",
//     "images/rachel.jpg",
//     "images/senjuti.jpg",
//   ];
//
//   // List to store the fetched data
//   List<dynamic> dataList = [];
//
//   // Loading indicator flag
//   bool _isLoading = true;
//
//   // List to track selected items
//   List<bool> selectedItems = [];
//
//   @override
//   void initState() {
//     super.initState();
//     printSharedPreferencesData(); // Load shared preferences
//     getCategories(); // Fetch categories data
//   }
//
//   Future<void> getCategories() async {
//     print("start");
//     var headers = {
//       'Cookie': 'x-clockwork=%7B%22requestId%22%3A%221690967253-5519-388169370%22%2C%22version%22%3A%225.1.12%22%2C%22path%22%3A%22%5C%2F__clockwork%5C%2F%22%2C%22webPath%22%3A%22%5C%2Fclockwork%5C%2Fapp%22%2C%22token%22%3A%2269aea927%22%2C%22metrics%22%3Atrue%2C%22toolbar%22%3Atrue%7D'
//     };
//
//     var request = http.Request('GET', Uri.parse('http://favoriteflyer.ca/api/buisness_categories'));
//
//     // Add headers to the request
//     request.headers.addAll(headers);
//
//     // Send the request and wait for the response
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       // Parse the response data
//       var res = await response.stream.bytesToString();
//       var body = jsonDecode(res);
//
//       // Store the data in dataList
//       dataList = body['data'];
//
//       // Initialize selectedItems with false values for each item in dataList
//       selectedItems = List<bool>.generate(dataList.length, (index) => false);
//       loadSelectedCategories();
//
//       setState(() {
//         dataList;
//       });
//       setState(() {
//         dataList;
//       });
//       setState(() {
//         _isLoading = false;
//       });
//     } else {
//       print(response.reasonPhrase);
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   void toggleItemSelection(int index) {
//     setState(() {
//       selectedItems[index] = !selectedItems[index];
//     });
//   }
//
//   // List to store selected data
//   final selectedDataList = <Map<String, dynamic>>[];
//
//   void printAndRemoveSelectedItems() {
//     for (int i = 0; i < selectedItems.length; i++) {
//       if (selectedItems[i]) {
//         selectedDataList.add({
//           'id': dataList[i]['id'],
//           'name': dataList[i]['name'],
//         });
//       }
//     }
//
//     print(selectedDataList);
//   }
//
//   // FCM token
//   String? fcmToken;
//
//   void printSharedPreferencesData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     fcmToken = prefs.getString('fcmToken') ?? 'N/A'; // Load FCM token
//     print('token: $fcmToken');
//     loadSelectedCategories();
//   }
//
//   // Loading flag for the update process
//   bool isLoad = false;
//
//   Future<void> uploadSelectedItems(List<Map<String, dynamic>> selectedDataList) async {
//     setState(() {
//       isLoad = true;
//     });
//
//     final firestore = FirebaseFirestore.instance;
//
//     for (final item in selectedDataList) {
//       await firestore.collection(fcmToken.toString()).add({
//         'id': item['id'],
//         'name': item['name'],
//       });
//     }
//
//     Fluttertoast.showToast(
//       msg: "Update Successfully",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.CENTER,
//       backgroundColor: AppColor.buttonColor,
//       textColor: Colors.white,
//       fontSize: 16.0,
//     );
//
//     setState(() {
//       isLoad = false;
//     });
//   }
//
//   // List to maintain selected categories locally
//   var selectedCategories = [];
//
//   // Function to load selected categories from Firestore
//   Future<void> loadSelectedCategories() async {
//     print("selected ids  fcmTokenr == ${fcmToken}");
//     final firestore = FirebaseFirestore.instance;
//     final userCategoriesCollection = firestore.collection(fcmToken.toString());
//     final querySnapshot = await userCategoriesCollection.get();
//
//     final selectedCategoryIds = querySnapshot.docs.map((doc) => doc['id'].toString()).toList();
//     print("selected ids  forebase == ${selectedCategoryIds}");
//     setState(() {
//       selectedCategories = selectedCategoryIds;
//
//       print("selected ids  r == ${selectedCategories}");
//       // Update selectedItems based on loaded categories
//       selectedItems = List<bool>.generate(dataList.length, (index) => selectedCategories.contains(dataList[index]['id'].toString()));
//     });
//   }
//   // Function to update selected categories in Firestore
//   Future<void> updateSelectedCategories() async {
//   setState(() {
//     isLoad = true;
//   });
//     final firestore = FirebaseFirestore.instance;
//     final userCategoriesCollection = firestore.collection(fcmToken.toString());
//
//     // Get a list of all selected category IDs
//     final selectedCategoryIds = selectedDataList.map((selected) => selected['id']).toList();
//
//     // Fetch the existing documents in the user's collection
//     final querySnapshot = await userCategoriesCollection.get();
//
//     // Iterate through the documents and delete those that are not in the selectedCategoryIds list
//     for (final doc in querySnapshot.docs) {
//       final categoryId = doc['id'];
//       if (!selectedCategoryIds.contains(categoryId)) {
//         await doc.reference.delete();
//       }
//     }
//
//     // Add selected categories to Firestore
//     for (final item in selectedDataList) {
//       if (!selectedCategories.contains(item['id'])) {
//         await userCategoriesCollection.add({
//           'id': item['id'],
//           'name': item['name'],
//         });
//       }
//     }
//
//     // Update selectedCategories list after the update
//     selectedCategories = selectedCategoryIds;
//
//     Fluttertoast.showToast(
//       msg: "Update Successfully",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.CENTER,
//       backgroundColor: AppColor.buttonColor,
//       textColor: Colors.white,
//       fontSize: 16.0,
//     );
//
//     setState(() {
//       isLoad = false;
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const MyAppBar(),
//       backgroundColor: Theme.of(context).primaryColor,
//       body:
//       _isLoading
//           ? const CircleProgressIndicator()
//           : Container(
//         padding: const EdgeInsets.all(16),
//         child: dataList.isNotEmpty
//             ? Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: dataList.length,
//                 itemBuilder: (BuildContext, index) {
//                   final isSelected = selectedItems[index];
//                   return Padding(
//                     padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
//                     child: InkWell(
//                       onTap: () {
//                         toggleItemSelection(index);
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage(images[index]),
//                             fit: BoxFit.cover,
//                             colorFilter: ColorFilter.mode(
//                               Colors.black.withOpacity(0.3),
//                               BlendMode.dstATop,
//                             ),
//                           ),
//                           border: Border.all(
//                             color: isSelected
//                                 ? Colors.blue
//                                 : const Color(0xff4D4C51),
//                           ),
//                           color: const Color(0xFF292839),
//                           borderRadius: const BorderRadius.all(
//                             Radius.circular(20),
//                           ),
//                         ),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             CircleAvatar(
//                               backgroundImage:
//                               AssetImage(images[index]),
//                               radius: 27,
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Expanded(
//                               flex: 8,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   AutoSizeText(
//                                     dataList[index]["name"].toString(),
//                                     maxLines: 1,
//                                     style: const TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 19,
//                                     ),
//                                   ),
//                                   dataList[index]["description"].toString() ==null
//                                       ? Text("null")
//                                       : Padding(
//                                     padding: const EdgeInsets.only(top: 12),
//                                     child: AutoSizeText(
//                                       dataList[index]["description"].toString() ?? "",
//                                       style: const TextStyle(
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             isSelected
//                                 ? Expanded(
//                               flex: 2,
//                               child: Container(
//                                 height: 35,
//                                 width: 35,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Colors.green,
//                                 ),
//                                 child: Center(
//                                   child: Icon(
//                                     Icons.done,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             )
//                                 : Container(),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             isLoad?Center(child: CircularProgressIndicator(color: Colors.green,)):
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: InkWell(
//                 onTap: () async {
//                   printAndRemoveSelectedItems();
//                   await updateSelectedCategories();
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: AppColor.buttonColor,
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   height: 50,
//                   width: double.infinity,
//                   child: Center(
//                     child: ReusableText(
//                       size: 20,
//                       color: AppColor.primaryWhite,
//                       weight: FontWeight.w600,
//                       title: 'Update',
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         )
//             : const NoDataText(),
//       ),
//     );
//   }
// }
////






import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffadvertisement/component/circle_progress_indicator.dart';
import 'package:ffadvertisement/component/no_data_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../component/my_app_bar.dart';
import '../onboarding/consts/reusable_text.dart';
import '../onboarding/utils/app_color.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({Key? key}) : super(key: key);

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  List<String> images = [
    "images/jason.jpg",
    "images/edward.jpg",
    "images/ashkan.jpg",
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

  // List to store the fetched data
  List<dynamic> dataList = [];

  // Loading indicator flag
  bool _isLoading = true;

  // List to track selected items
  List<bool> selectedItems = [];

  @override
  void initState() {
    super.initState();
    printSharedPreferencesData(); // Load shared preferences
    getCategories(); // Fetch categories data
  }

  Future<void> getCategories() async {
    print("start");
    var headers = {
      'Cookie': 'x-clockwork=%7B%22requestId%22%3A%221690967253-5519-388169370%22%2C%22version%22%3A%225.1.12%22%2C%22path%22%3A%22%5C%2F__clockwork%5C%2F%22%2C%22webPath%22%3A%22%5C%2Fclockwork%5C%2Fapp%22%2C%22token%22%3A%2269aea927%22%2C%22metrics%22%3Atrue%2C%22toolbar%22%3Atrue%7D'
    };

    var request = http.Request('GET', Uri.parse('http://favoriteflyer.ca/api/buisness_categories'));

    // Add headers to the request
    request.headers.addAll(headers);

    // Send the request and wait for the response
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // Parse the response data
      var res = await response.stream.bytesToString();
      var body = jsonDecode(res);

      // Store the data in dataList
      dataList = body['data'];

      // Initialize selectedItems with false values for each item in dataList
      selectedItems = List<bool>.generate(dataList.length, (index) => false);
      loadSelectedCategories();

      setState(() {
        dataList;
      });
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
//

  void toggleItemSelection(int index) {
    setState(() {
      selectedItems[index] = !selectedItems[index];
    });
  }

  // List to store selected data
  final selectedDataList = <Map<String, dynamic>>[];

  void printAndRemoveSelectedItems() {
    for (int i = 0; i < selectedItems.length; i++) {
      if (selectedItems[i]) {
        selectedDataList.add({
          'id': dataList[i]['id'],
          'name': dataList[i]['name'],
        });
      }
    }

    print(selectedDataList);
  }

  // FCM token
  String? fcmToken;

  void printSharedPreferencesData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fcmToken = prefs.getString('fcmToken') ?? 'N/A'; // Load FCM token
    print('token: $fcmToken');
    loadSelectedCategories();
  }

  // Loading flag for the update process
  bool isLoad = false;

  Future<void> uploadSelectedItems(List<Map<String, dynamic>> selectedDataList) async {
    setState(() {
      isLoad = true;
    });

    final firestore = FirebaseFirestore.instance;

    for (final item in selectedDataList) {
      await firestore.collection(fcmToken.toString()).add({
        'id': item['id'],
        'name': item['name'],
      });
    }

    Fluttertoast.showToast(
      msg: "Update Successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: AppColor.buttonColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    setState(() {
      isLoad = false;
    });
  }

  // List to maintain selected categories locally
  var selectedCategories = [];

  // Function to load selected categories from Firestore
  Future<void> loadSelectedCategories() async {
    final firestore = FirebaseFirestore.instance;
    final userCategoriesCollection = firestore.collection(fcmToken.toString());
    final querySnapshot = await userCategoriesCollection.get();

    final selectedCategoryIds = querySnapshot.docs.map((doc) => doc['id'].toString()).toList();

    setState(() {
      selectedCategories = selectedCategoryIds;

      // Update selectedItems based on loaded categories
      selectedItems = List<bool>.generate(dataList.length, (index) => selectedCategories.contains(dataList[index]['id'].toString()));
    });
  }

  // Function to update selected categories in Firestore
  Future<void> updateSelectedCategories() async {
    setState(() {
      isLoad = true;
    });

    final firestore = FirebaseFirestore.instance;
    final userCategoriesCollection = firestore.collection(fcmToken.toString());

    // Get a list of all selected category IDs
    final selectedCategoryIds = selectedDataList.map((selected) => selected['id']).toList();

    // Fetch the existing documents in the user's collection
    final querySnapshot = await userCategoriesCollection.get();

    // Iterate through the documents and delete those that are not in the selectedCategoryIds list
    for (final doc in querySnapshot.docs) {
      final categoryId = doc['id'];
      if (!selectedCategoryIds.contains(categoryId)) {
        await doc.reference.delete();
      }
    }

    // Add selected categories to Firestore
    for (final item in selectedDataList) {
      if (!selectedCategories.contains(item['id'])) {
        await userCategoriesCollection.add({
          'id': item['id'],
          'name': item['name'],
        });
      }
    }

    // Update selectedCategories list after the update
    selectedCategories = selectedCategoryIds;

    Fluttertoast.showToast(
      msg: "Update Successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: AppColor.buttonColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    setState(() {
      isLoad = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      backgroundColor: Theme.of(context).primaryColor,
      body: _isLoading
          ? const CircleProgressIndicator()
          : Container(
        padding: const EdgeInsets.all(16),
        child: dataList.isNotEmpty
            ? Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (BuildContext, index) {
                  final isSelected = selectedItems[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: InkWell(
                      onTap: () {
                        toggleItemSelection(index);
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
                            color: isSelected
                                ? Colors.blue
                                : const Color(0xff4D4C51),
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
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText(
                                    dataList[index]["name"].toString(),
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 19,
                                    ),
                                  ),
                                  dataList[index]["description"].toString() == null
                                      ? Text("null")
                                      : Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: AutoSizeText(
                                      dataList[index]["description"].toString() ?? "",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            isSelected
                                ? Expanded(
                              flex: 2,
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.done,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // isLoad
            //     ? Center(child: CircularProgressIndicator(color: Colors.green,))
            //     : Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: InkWell(
            //     onTap: () async {
            //       printAndRemoveSelectedItems();
            //       await updateSelectedCategories();
            //     },
            //     child: Container(
            //       decoration: BoxDecoration(
            //         color: AppColor.buttonColor,
            //         borderRadius: BorderRadius.circular(15),
            //       ),
            //       height: 50,
            //       width: double.infinity,
            //       child: Center(
            //         child: ReusableText(
            //           size: 20,
            //           color: AppColor.primaryWhite,
            //           weight: FontWeight.w600,
            //           title: 'Update',
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        )
            : const NoDataText(),
      ),

        floatingActionButton: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: double.infinity,
            child: FloatingActionButton.extended(

      backgroundColor: Colors.green,
      foregroundColor: Colors.black,
      onPressed: () async{
            printAndRemoveSelectedItems();
                   await updateSelectedCategories();
      },
    //  icon: Icon(Icons.add),
      label: isLoad
                     ? Center(child: CircularProgressIndicator(color: Colors.black,)):
      Text('Update'),
    ),
          ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,


    );
  }
}
