import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final void Function() onPressed;
  final Widget title;
  final EdgeInsets? padding;
  const Button({
    super.key,
    required this.onPressed,
    required this.title,
    this.padding,
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        padding: widget.padding ?? const EdgeInsets.all(08),
        backgroundColor: const Color(0xFF6AA71A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(36.0),
        ),
        minimumSize: const Size.fromHeight(50),
      ),
      child: widget.title,
    );
  }
}
