import 'package:flutter/material.dart';

class NoDataText extends StatelessWidget {
  const NoDataText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "No Data Found",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
