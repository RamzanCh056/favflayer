import 'package:flutter/material.dart';

class FastFood extends StatefulWidget {
  const FastFood();

  @override
  State<FastFood> createState() => _FastFoodState();
}

class _FastFoodState extends State<FastFood> {
  final List<String> imagePaths = [
    'assets/fastfood.png',
    'assets/fastfood.png',
    'assets/fastfood.png',
    'assets/fastfood.png',
    'assets/fastfood.png',
  ];

  final List<String> titles = [
    'KFC Family Festival Deal',
    'KFC Family Festival Deal',
    'KFC Family Festival Deal',
    'KFC Family Festival Deal',
    'KFC Family Festival Deal',
  ];

  final List<String> descriptions = [
    'Its deal for almost all KFC franchises Canada, on dining and also get from drive through at 30% OFF.',
    'It’s deal for almost all KFC franchises Canada, on dining and also get from drive through at 30% OFF.',
    'It’s deal for almost all KFC franchises Canada, on dining and also get from drive through at 30% OFF.',
    'It’s deal for almost all KFC franchises Canada, on dining and also get from drive through at 30% OFF.',
    'It’s deal for almost all KFC franchises Canada, on dining and also get from drive through at 30% OFF.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff28293F),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff28293F),
        centerTitle: true,
        title: const Text(
          'Fast Food',
          style: TextStyle(
            fontSize: 22,
            color: Color(0xffFFFFFF),
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: Container(
          margin: const EdgeInsets.all(
              7), // Replace 8 with your desired margin value
          child: Image.asset(
            'assets/backarrow.png', // Replace 'assets/backarrow.png' with your actual image path
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 5, // Number of items in the list
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    imagePaths[index],
                    width: 386,
                    height: 269,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.only(right: 150),
                  child: Text(
                    titles[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                      color: Color(0xffFFFFFF),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    descriptions[index],
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffAFAFAF),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
