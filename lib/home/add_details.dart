// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../component/my_app_bar.dart';
class AddDetails extends StatefulWidget {
   AddDetails({ required this.data, required this.baseAddName,Key? key}) : super(key: key);
  var data=[];
  var baseAddName;
  @override
  State<AddDetails> createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  @override
  void initState() {
    print("the data array = ${widget.data} total add ${widget.data.length}");
    super.initState();

  }
   var imageUrl = "http://favoriteflyer.ca/flyers/";

  @override
  Widget build(BuildContext context) {
    return  SafeArea(

      child: Scaffold(
       // backgroundColor: const Color(0xff28293F),
      appBar:  AppBar(
        leadingWidth: 30,
        elevation: 0,
        centerTitle: true,
        shadowColor: Colors.transparent,
        title: Text(
          widget.baseAddName.toString(),
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ),
        backgroundColor: Theme.of(context).primaryColor,
      body:  ListView.builder(
        itemCount: widget.data.length, // Number of items in the list
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    imageUrl+widget.data[index]['media'],
                    width: 386,
                    height: 269,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(

                  widget.data[index]['business_name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                    color: Color(0xffFFFFFF),
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 8.0),
                Text(
                  widget.data[index]['caption'],
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffAFAFAF),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      ),
    );
  }
}
