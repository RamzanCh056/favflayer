import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



import 'package:ffadvertisement/onboarding/consts.dart';
import 'package:ffadvertisement/onboarding/screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../consts/reusable_text.dart';
import '../utils/app_color.dart';
import '../utils/app_utils.dart';
import 'information_geth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double latitude = 0.0;
  double longitude = 0.0;
  String postalCode = 'Enter Zip Code';
  String _country = 'Unknown country ';
  Position? _currentLocation;
  Future<void> _getLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are permanently denied. Handle accordingly.
        return;
      }
      if (permission == LocationPermission.denied) {
        // Permissions are denied for now. Handle accordingly.
        return;
      }
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      _getLocation();
    }
  }

  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentLocation = position;
        // latitude = 37.7749;
        // longitude = -122.4194;
        latitude = position.latitude;
        longitude = position.longitude;
      });
      fetchPostalCode();
      await _getZipCodeFromCoordinates(position.latitude, position.longitude);
    } catch (e) {
      print("Error getting location: $e");
    }
  }
  @override
  void initState() {
    super.initState();
    //_getLocationPermission();
    // Replace with your actual latitude and longitude coordinates
    // latitude = 37.7749;
    // longitude = -122.4194;
   // fetchPostalCode();
  }



  Future<void> fetchPostalCode() async {
    final apiKey = 'AIzaSyAlWLuEzszKgldMmuo9JjtKLxe9MGk75_k';
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      print("decoded $decoded}");
      final results = decoded['results'] as List<dynamic>;
      print("fdfd $results}");

      if (results.isNotEmpty) {
        final addressComponents = results[0]['address_components'] as List<dynamic>;

        for (final component in addressComponents) {
          final types = component['types'] as List<dynamic>;

          if (types.contains('postal_code')) {
            setState(() {
              postalCode = component['long_name'];
            });
            break;
          }


        }
      }
    } else {
      print('Error fetching postal code: ${response.statusCode}');
    }
  }

  Future<void> _getZipCodeFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
       // String zipCode = placemark.postalCode ?? 'Unknown Zip Code';
        String country = placemark.country ?? 'Unknown country';
        setState(() {
          //_zipCode = zipCode;
          _country = country;
          AppUtils.navigateTo(
              context,
              InformationGethring(
               zipCode: postalCode,
                country : _country,
                // country: _country,
              ));
        });
        print('Zip Code is : $postalCode');
        print('Zip _country: ${_country}');
        print('Zip placemarks: ${placemarks}');
      }
    } catch (e) {
      print("Error getting zip code: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'images/white_logo 1.png',
                height: 127,
                width: 279,
              ),
              Image.asset(
                'images/location.png',
              ),
              SizedBox(
                height: 40,
              ),

              Padding(
                padding:  EdgeInsets.all(10),
                child: Text("Enable location services to get EXCLUSIVE Real Time Promotions \nfrom stores and restaurants you are in walking distance of. Click Favorite Flyer to save money and time,everytime you go out to shop or dine.", 
                style: TextStyle(
                  
                 fontWeight: FontWeight.w500,
                  fontSize: 19,
                  color: AppColor.greyColor
                ),
                textAlign: TextAlign.center,
                ),
              ),
              // ReusableText(
              //   textAlign: TextAlign.center,
              //   color: AppColor.greyColor,
              //   weight: FontWeight.w500,
              //   size: 19,
              //   title:
              //   // 'We will never share or sell the\ninformation you provide us, its just\nused to get your money saving\ncoupons and promotions wherever\nyou shop.',
              // ),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  _getLocationPermission();

                  // Future.delayed(const Duration(seconds: 2), () {
                  //   Navigator.pushAndRemoveUntil(
                  //       context,
                  //       MaterialPageRoute(builder: (_) => HomePage()),
                  //           (route) => false);
                  // });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColor.buttonColor,
                        borderRadius: BorderRadius.circular(19)),
                    height: 50,
                    width: double.infinity,
                    child: Center(
                      child: ReusableText(
                        size: 20,
                        color: AppColor.primaryWhite,
                        weight: FontWeight.w600,
                        title: 'Enable Location',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  AppUtils.navigateTo(
                      context,
                      InformationGethring(
                        zipCode: "Enter Zip Code",
                        country: "Select Country",
                      ));
                },
                child: ReusableText(
                  title: 'Skip',
                  size: 20,
                  color: AppColor.primaryWhite,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


//
// //
// //
// //
// //
// import 'package:ffadvertisement/onboarding/consts.dart';
// import 'package:ffadvertisement/onboarding/screen/welcome_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import '../consts/reusable_text.dart';
// import '../utils/app_color.dart';
// import '../utils/app_utils.dart';
// import 'information_geth.dart';
//
// class LocationScreen extends StatefulWidget {
//   const LocationScreen({super.key});
//
//   @override
//   State<LocationScreen> createState() => _LocationScreenState();
// }
//
// class _LocationScreenState extends State<LocationScreen> {
//   Position? _currentLocation;
//   String _zipCode = 'Unknown Zip Code';
//   String _country = 'Unknown country ';
//   Future<void> _getLocationPermission() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.deniedForever) {
//         // Permissions are permanently denied. Handle accordingly.
//         return;
//       }
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied for now. Handle accordingly.
//         return;
//       }
//     }
//
//     if (permission == LocationPermission.always ||
//         permission == LocationPermission.whileInUse) {
//       _getLocation();
//     }
//   }
//
//   Future<void> _getLocation() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//
//       setState(() {
//         _currentLocation = position;
//       });
//
//       await _getZipCodeFromCoordinates(position.latitude, position.longitude);
//     } catch (e) {
//       print("Error getting location: $e");
//     }
//   }
//
//   Future<void> _getZipCodeFromCoordinates(
//       double latitude, double longitude) async {
//     try {
//       List<Placemark> placemarks =
//           await placemarkFromCoordinates(latitude, longitude);
//
//       if (placemarks.isNotEmpty) {
//         Placemark placemark = placemarks[0];
//         String zipCode = placemark.postalCode ?? 'Unknown Zip Code';
//         String country = placemark.country ?? 'Unknown country';
//         setState(() {
//           _zipCode = zipCode;
//           _country = country;
//           AppUtils.navigateTo(
//               context,
//               InformationGethring(
//                 zipCode: _zipCode,
//                   country : _country,
//                  // country: _country,
//               ));
//         });
//         print('Zip Code is : $_zipCode');
//         print('Zip _country: ${_country}');
//         print('Zip placemarks: ${placemarks}');
//       }
//     } catch (e) {
//       print("Error getting zip code: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.backgroundColor,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 20.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'images/white_logo 1.png',
//                 height: 127,
//                 width: 279,
//               ),
//               Image.asset(
//                 'images/location.png',
//               ),
//               SizedBox(
//                 height: 40,
//               ),
//               ReusableText(
//                 textAlign: TextAlign.center,
//                 color: AppColor.greyColor,
//                 weight: FontWeight.w500,
//                 size: 19,
//                 title:
//                     'We will never share or sell the\ninformation you provide us, its just\nused to get your money saving\ncoupons and promotions wherever\nyou shop.',
//               ),
//               SizedBox(
//                 height: 50,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   _getLocationPermission();
//
//                   // Future.delayed(const Duration(seconds: 2), () {
//                   //   Navigator.pushAndRemoveUntil(
//                   //       context,
//                   //       MaterialPageRoute(builder: (_) => HomePage()),
//                   //           (route) => false);
//                   // });
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: AppColor.buttonColor,
//                         borderRadius: BorderRadius.circular(19)),
//                     height: 50,
//                     width: double.infinity,
//                     child: Center(
//                       child: ReusableText(
//                         size: 20,
//                         color: AppColor.primaryWhite,
//                         weight: FontWeight.w600,
//                         title: 'Enable Location',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               InkWell(
//                 onTap: () {
//                   AppUtils.navigateTo(
//                       context,
//                       InformationGethring(
//                         zipCode: "Enter Zip Code",
//                         country: "Select Country",
//                       ));
//                 },
//                 child: ReusableText(
//                   title: 'Skip',
//                   size: 20,
//                   color: AppColor.primaryWhite,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
