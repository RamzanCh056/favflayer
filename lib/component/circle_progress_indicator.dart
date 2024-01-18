import 'package:flutter/material.dart';

class CircleProgressIndicator extends StatelessWidget {
  const CircleProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Color(0xFF6AA71A),
      ),
    );
  }
}
