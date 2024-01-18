import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class FlyerPost extends StatelessWidget {
  final String name;
  final String imageSrc;
  final String viewNum;
  const FlyerPost({
    super.key,
    required this.name,
    required this.imageSrc,
    required this.viewNum,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: const Color.fromRGBO(106, 167, 26, 1),
                radius: 25,
                child: Center(
                  child: AutoSizeText(
                    name[0].toString().toUpperCase(),
                    style: const TextStyle(
                      fontSize: 35,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              AutoSizeText(
                name.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Flexible(
          flex: 8,
          child: Container(
            color: const Color(0xFF292839),
            padding: const EdgeInsets.symmetric(horizontal: 08, vertical: 05),
            height: double.infinity,
            width: double.infinity,
            child: Image.network(
              imageSrc,
              // fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          ),
        ),
        const SizedBox(
          height: 05,
        ),
        Chip(
          backgroundColor: const Color(0xFF292839),
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: Color(0xFF292839),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          label: AutoSizeText(
            viewNum.toString(),
            softWrap: true,
            style: const TextStyle(
              // decoration: TextDecoration.,
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          avatar: const Icon(
            Icons.visibility_outlined,
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(10),
        ),
        // ),
      ],
    );
  }
}
