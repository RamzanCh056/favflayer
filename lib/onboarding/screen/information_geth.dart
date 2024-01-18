import 'dart:async';

import 'package:country_picker/country_picker.dart';
import 'package:ffadvertisement/home/home_index.dart';
import 'package:ffadvertisement/onboarding/screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../component/dialoge_widget.dart';
import '../../utils/storage_service.dart';
import '../consts.dart';
import '../consts/reusable_text.dart';
import '../utils/app_color.dart';
import '../utils/app_utils.dart';
import 'location_screen.dart';

class InformationGethring extends StatefulWidget {
  var zipCode;
  var country;

  InformationGethring({required this.zipCode,required this.country, Key? key}) : super(key: key);

  @override
  State<InformationGethring> createState() => _InformationGethringState();
}

class _InformationGethringState extends State<InformationGethring> {
  TextEditingController ageController = TextEditingController();
  TextEditingController minAgeController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> age = [
    '24',
    '30',
    '35',
    '40',
    '45',
    '50',
    '55',
    '60',
    '65',
    '70',
    '75',
    '75+',
  ];
  List<String> minAge = [
    "18",
    "26",
    "31",
    "36",
    "41",
    "46",
    "51",
    "60",
    "65",
    "70",
  ];
  List<String> gender = [
    'Male',
    'Female',
    'Not Binary',
  ];
  String _selectedCountryCode = 'CA';
  String? _selectedItem;
  String? selectGender;
  String? selectAge;
  String? selectMinAge;
  List<String> _items = [
    'Item 1',
    'Item 2',
    'Item 3',
  ];
  Country? _selectedCountry;
  

  @override
  void initState() {
    super.initState();
   
    _searchController.addListener(_onSearchTextChanged);
    print('Zip Code hao : ${widget.zipCode}');
    zipCodeController.text = widget.zipCode;
    _searchController.text =widget.country;

      loadSavedData();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchTextChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged() {
    setState(() {
      // No need to update the _selectedCountry when the search text changes.
      // Only update the search text in this method.
    });
  }

Future<void> saveDataToSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  // Save each field's data
  prefs.setString('name', nameController.text);
  prefs.setString('zipCode', zipCodeController.text);
  prefs.setString('age', ageController.text);
  prefs.setString('country', _searchController.text);
  prefs.setString('gender', genderController.text);
  prefs.setString('minAge', minAgeController.text);
  prefs.setString('fcmToken', StaticInfo.fcmToken.toString());
}
  Future<void> loadSavedData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  nameController.text = prefs.getString('name') ?? '';
  zipCodeController.text = prefs.getString('zipCode') ?? '';
  _searchController.text = prefs.getString('country') ?? '';

  // Set the selected values for age and gender dropdowns
  String loadedAge = prefs.getString('age') ?? '';
  if (age.contains(loadedAge)) {
    selectAge = loadedAge;
  } else {
    selectAge = null; // Set to null if the loaded value is not valid
  }

  String loadedGender = prefs.getString('gender') ?? '';
  if (gender.contains(loadedGender)) {
    selectGender = loadedGender;
  } else {
    selectGender = null; // Set to null if the loaded value is not valid
  }

  setState(() {}); // Update the UI to reflect the loaded values
}


  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "Please give specific information",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff878787),
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      cursorColor: Colors.white,
                      validator: (value) =>
                          value!.isEmpty ? 'Name cannot be blank' : null,
                      style: TextStyle(color: Colors.white),
                      controller: nameController,
                      decoration: InputDecoration(
                          filled: true, // Fill the background
                          fillColor: Color(0xff241F31),
                          contentPadding: EdgeInsets.all(25),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(
                              color: Color(0xff4D4C51),
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(
                              color: Color(0xff4D4C51),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(
                              color: Color(0xff4D4C51),
                              width: 2.0,
                            ),
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 13, right: 10),
                            child: IconButton(
                              icon: const ImageIcon(
                                AssetImage('assets/Vector.png'),
                                size: 25,
                                color: Color(0xff88B172),
                              ),
                              onPressed: () {
                                // Handle back button press
                              },
                            ),
                          ),
                          hintText: 'Enter Full Name',
                          hintStyle:
                              const TextStyle(color: Color((0xff4D4C51)))),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Country',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff878787),
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xff211A2c),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.language,
                                color: Color(0xff88B172)), // Set icon color
                            onPressed: () {
                              // Perform search action using searchText
                            },
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                _openCountryPicker();
                              },
                              child: TextFormField(
                                validator: (value) => value!.isEmpty
                                    ? 'country cannot be blank'
                                    : null,

                                enabled: false,
                                controller: _searchController,
                                style: TextStyle(
                                    color: Colors.white), // Set text color
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xff211A2c),
                                  border: InputBorder.none,
                                  hintText: 'Select Country',
                                  hintStyle: TextStyle(
                                      color:
                                          Colors.grey), // Set hint text color
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_drop_down,
                                color: Color(0xff88B172)), // Set icon color
                            onPressed: () {
                              _openCountryPicker();
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Postal/Zip Code',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff878787),
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      cursorColor: Colors.white,
                      validator: (value) =>
                          value!.isEmpty ? 'Zip cannot be blank' : null,
                      style: TextStyle(color: Colors.white),
                      controller: zipCodeController,
                      decoration: InputDecoration(
                          filled: true, // Fill the background
                          fillColor: Color(0xff241F31),
                          contentPadding: EdgeInsets.all(25),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(
                              color: Color(0xff4D4C51),
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(
                              color: Color(0xff4D4C51),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(
                              color: Color(0xff4D4C51),
                              width: 2.0,
                            ),
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 13, right: 10),
                            child: IconButton(
                              icon: const ImageIcon(
                                AssetImage('assets/Vector02.png'),
                                size: 25,
                                color: Color(0xff88B172),
                              ),
                              onPressed: () {
                                // Handle back button press
                              },
                            ),
                          ),
                          hintText: 'Enter Postal/Zip Code',
                          hintStyle:
                              const TextStyle(color: Color((0xff4D4C51)))),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Max Age',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff878787),
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xff241F31),
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: Color(0xff4D4C51), width: 0.8),
                      ),
                      child: DropdownButtonFormField<String>(
                        hint: Text(
                          'Select Age Group',
                          style: TextStyle(color: Color(0xff4D4C51)),
                        ),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Color(
                              0xff88B172), // Set the color of the dropdown icon
                        ),
                        value: selectAge,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectAge = newValue;
                            ageController.text = newValue.toString();
                          });
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(21),
                          border: InputBorder.none,
                        ),
                        isExpanded: true,
                        items:
                            age.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Row(
                              children: [
                                Image.asset('assets/Vector.png',
                                    width: 25, height: 25),
                                SizedBox(
                                  width: 21,
                                ),
                                Text(
                                  value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Min Age',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff878787),
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xff241F31),
                        borderRadius: BorderRadius.circular(20),
                        border:
                        Border.all(color: Color(0xff4D4C51), width: 0.8),
                      ),
                      child: DropdownButtonFormField<String>(
                        hint: Text(
                          'Select Age Group',
                          style: TextStyle(color: Color(0xff4D4C51)),
                        ),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Color(
                              0xff88B172), // Set the color of the dropdown icon
                        ),
                        value: selectMinAge,
                        onChanged: (String? newValue) {
                          setState(() {

                            selectMinAge = newValue;

                            minAgeController.text = newValue.toString();
                          });
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(21),
                          border: InputBorder.none,
                        ),
                        isExpanded: true,
                        items:
                        minAge.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Row(
                              children: [
                                Image.asset('assets/Vector.png',
                                    width: 25, height: 25),
                                SizedBox(
                                  width: 21,
                                ),
                                Text(
                                  value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Gender',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff878787),
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xff241F31),
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: Color(0xff4D4C51), width: 0.8),
                      ),
                      child: DropdownButtonFormField<String>(
                        hint: Text(
                          'Select Gender Groups',
                          style: TextStyle(color: Color(0xff4D4C51)),
                        ),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Color(
                              0xff88B172), // Set the color of the dropdown icon
                        ),
                        value: selectGender,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectGender = newValue;
                            genderController.text = newValue.toString();
                          });
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(21),
                          border: InputBorder.none,
                        ),
                        isExpanded: true,
                        items: gender
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Row(
                              children: [
                                Image.asset('assets/Vector.png',
                                    width: 25, height: 25),
                                SizedBox(
                                  width: 21,
                                ),
                                Text(
                                  value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                    onTap: () async{
                      if (_formKey.currentState!.validate()) {
                        _showDeleteToast();
                            await saveDataToSharedPreferences(); 
                        StaticInfo.userName = nameController.text;
                        StaticInfo.zipCode = zipCodeController.text;
                        StaticInfo.age = ageController.text;
                        StaticInfo.country = _searchController.text;
                        StaticInfo.gender = genderController.text;


                         setState(() {});
                    // AppUtils.navigateTo(context,HomePageContent());
   
                      Navigator.of(context).pushNamed('/home');
                        //   Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePageContent()));
                      }
                      // print("gender ${  genderController.text}");
                      // print("country ${  _searchController.text}");
                      // print("zip ${  zipCodeController.text}");
                      // print("age ${  ageController.text}");
                      // print("name ${  nameController.text}");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColor.buttonColor,
                          borderRadius: BorderRadius.circular(15)),
                      height: 50,
                      width: double.infinity,
                      child: Center(
                        child: ReusableText(
                          size: 20,
                          color: AppColor.primaryWhite,
                          weight: FontWeight.w600,
                          title: 'Update',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showDialogForAge() {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            titlePadding: EdgeInsets.zero,
            title: titleForDialog(context, 'Select Age'),
            content: Container(
              height: 400,
              width: 300,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            age[index],
                            maxLines: 2,
                            style: TextStyle(fontSize: 13),
                          )),
                        ],
                      ),
                      height: 40,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      ageController.text = age[index];
                      setState(() {});
                    },
                  );
                },
                itemCount: age.length,
                shrinkWrap: true,
              ),
            ),
          );
        });
  }

  void _openCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        setState(() {
          _selectedCountry = country;
          _searchController.clear();
          _searchController.text = '${country.name}${_searchController.text}';
        });
      },
    );
  }

   void _showDeleteToast() {
    Fluttertoast.showToast(
      msg: "Profile Update Successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: AppColor.buttonColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
