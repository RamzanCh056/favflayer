// ignore_for_file: non_constant_identifier_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

Container MyDropDown({
  required String label,
  required List<String> optionsList,
  required List<String> optionsName,
  required String value,
  required ValueChanged<String?> oncange,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 05,
    ),
    decoration: BoxDecoration(
      color: const Color(0xFF292839),
      borderRadius: BorderRadius.circular(08),
    ),
    child: DropdownButton(
      underline: Container(),
      items: optionsList.map((String items) {
        int num = int.parse(items) - 1;
        return DropdownMenuItem(
          value: items,
          child: AutoSizeText(
            optionsName[num],
            style: const TextStyle(color: Colors.white),
          ),
        );
      }).toList(),
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: Colors.white,
      ),
      disabledHint: Text(label),
      dropdownColor: const Color(0xFF292839),
      onChanged: oncange,
      hint: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
      value: value,
      isExpanded: true,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
  );
}
