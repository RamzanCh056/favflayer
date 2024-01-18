// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:dots_indicator/dots_indicator.dart';
// import 'package:flutter/material.dart';
//
// class Category_description extends StatefulWidget {
//   const Category_description();
//
//   @override
//   State<Category_description> createState() => _Category_descriptionState();
// }
//
// class _Category_descriptionState extends State<Category_description> {
//   int _currentIndex = 0;
//
//   List _images = [
//     'assets/fastfood.png',
//     'assets/fastfood.png',
//     'assets/fastfood.png',
//   ];
//
//   List<String> _descriptions = [
//     'Description 1',
//     'Description 2',
//     'Description 3',
//   ];
//
//   void _changeImage(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: const Color(0xff28293F),
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: const Color(0xff28293F),
//           centerTitle: true,
//           title: const Text(
//             'Catagory Description',
//             style: TextStyle(
//               fontSize: 22,
//               color: Color(0xffFFFFFF),
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           leading: Container(
//             margin: const EdgeInsets.all(
//                 7), // Replace 8 with your desired margin value
//             child: Image.asset(
//               'assets/backarrow.png',
//               // Replace 'assets/backarrow.png' with your actual image path
//               fit: BoxFit.contain,
//             ),
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.only(top: 20),
//           child: Column(
//             children: [
//               CarouselSlider(
//                 items: _images.map((imageUrl) {
//                   return Padding(
//                     padding: const EdgeInsets.only(left: 10),
//                     child: Container(
//                       height: 196,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8.0),
//                         image: DecorationImage(
//                           image: AssetImage(imageUrl),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//                 options: CarouselOptions(
//                   height: 196,
//                   viewportFraction: 1.0,
//                   enlargeCenterPage: false,
//                   onPageChanged: (index, _) {
//                     setState(() {
//                       _currentIndex = index;
//                     });
//                   },
//                 ),
//               ),
//               SizedBox(height: 10),
//               DotsIndicator(
//                 dotsCount: _images.length,
//                 position: _currentIndex,
//
//                 decorator: DotsDecorator(
//                 activeColor: Colors.amber,
//                   color: Colors.white,
//                   size: const Size.square(8.0),
//                   activeSize: const Size(20.0, 8.0),
//                   activeShape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5.0),
//                   ),
//                 ),
//               ),
//              const  SizedBox(
//                 height: 10,
//               ),
//               const Padding(
//                 padding: EdgeInsets.only(right: 160, top: 20),
//                 child: Text(
//                   "McDonald’s 2 in 1 Offer",
//                   style: TextStyle(
//                       fontSize: 18,
//                       color: Color(0xffFFFFFF),
//                       fontWeight: FontWeight.w600),
//                 ),
//               ),
//               SizedBox(height: 10,),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: Text(
//                   "McDonald's Special Holiday Warmer Offer with 2 Big Mac Burger(Chicken + Beef) + McCafe Chocolate Hot. This offer is available for only till summer holidays. This is for all the franchises in Toronto.",
//                   style: TextStyle(
//                       fontSize: 14,
//                       color: Color(0xffAFAFAF),
//                       fontWeight: FontWeight.w500),
//                 ),
//               ),
//
//            const Padding(
//              padding:  EdgeInsets.symmetric(horizontal: 10),
//              child:  Divider(color: Colors.white,height: 80,),
//            )
//             ],
//           ),
//         ));
//   }
// }
