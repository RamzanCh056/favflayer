// ignore_for_file: non_constant_identifier_names, sized_box_for_whitespace

import 'package:flutter/material.dart';

// class InputField extends StatelessWidget {
//   final String hintText;
//   final TextEditingController controller;
//   final bool obscureText;
//   final TextInputAction textInputAction;
//   final TextInputType keyboardType;
//   final validator;
//   const InputField({
//     super.key,
//     required this.hintText,
//     required this.controller,
//     required this.obscureText,
//     required this.textInputAction,
//     required this.keyboardType,
//     this.validator,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       obscureText: obscureText,
//       textInputAction: textInputAction,
//       keyboardType: keyboardType,
//       style: const TextStyle(
//         color: Colors.white,
//       ),
//       cursorColor: Colors.white,
//       decoration: InputDecoration(
//         border: const OutlineInputBorder(
//           borderSide: BorderSide(
//             width: 0,
//             style: BorderStyle.none,
//           ),
//           borderRadius: BorderRadius.all(
//             Radius.circular(8.0),
//           ),
//         ),
//         hintText: hintText.toString(),
//         hintStyle: const TextStyle(
//           color: Colors.white,
//         ),
//         filled: true,
//         fillColor: const Color(0xFF292839),
//       ),
//     );
//   }
// }
TextFormField InputField({
  required TextEditingController controller,
  required TextInputAction textInputAction,
  required TextInputType keyboardType,
  required String hintText,
   bool enabled =true,
  void Function(String)? onchanged,
  required bool obscureText,
  required bool suffix,
  required validator,
}) {
  return TextFormField(
    controller: controller,
    textInputAction: textInputAction,
    keyboardType: keyboardType,
    cursorColor: Colors.white,
    enabled: enabled,

    obscureText: obscureText,
    onChanged: onchanged ?? (value) {},
    style: const TextStyle(
      color: Colors.white,
    ),
    decoration: InputDecoration(
      suffixIconConstraints: const BoxConstraints(
        maxHeight: 20,
        maxWidth: 20,
      ),
      suffix: suffix
          ? Container(
              width: 20,
              height: 20,
              child: const CircularProgressIndicator(
                backgroundColor: Colors.green,
              ),
            )
          : null,
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Colors.white,
      ),
      filled: true,
      fillColor: const Color(0xFF292839),
    ),
    validator: validator ??
        () {
          return null;
        },
  );
}
