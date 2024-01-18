// ignore_for_file: library_private_types_in_public_api

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ListItems extends StatefulWidget {
  final Map? item;
  final ValueChanged<bool>? isSelected;
  final bool selected;
  const ListItems({
    Key? key,
    this.item,
    required this.selected,
    this.isSelected,
  }) : super(key: key);

  @override
  _ListItemsState createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    setState(() {
      isSelected = widget.selected;
    });
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: ListTile(
        tileColor: const Color(0xFF292839),
        selectedTileColor: const Color(0xFF292839),
        leading: isSelected
            ? const Icon(
                Icons.check_circle_outline,
              )
            : const Icon(
                Icons.circle_outlined,
              ),
        selected: isSelected ? true : false,
        selectedColor: const Color(0xFF6AA71A),
        iconColor: Colors.grey,
        onTap: () {
          setState(() {
            isSelected = !isSelected;
            widget.isSelected!(isSelected);
          });
        },
        horizontalTitleGap: 0,
        dense: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        title: AutoSizeText(
          widget.item!["title"].toString(),
          maxLines: 1,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: AutoSizeText(
            widget.item!["description"].toString(),
            style: const TextStyle(color: Colors.white),
            maxLines: 2,
          ),
        ),
        contentPadding: const EdgeInsets.all(12),
      ),
    );
  }
}

class ListItemsSignUp extends StatefulWidget {
  final Map? item;
  final ValueChanged<bool>? isSelected;
  const ListItemsSignUp({
    Key? key,
    this.item,
    this.isSelected,
  }) : super(key: key);

  @override
  _ListItemsSignUpState createState() => _ListItemsSignUpState();
}

class _ListItemsSignUpState extends State<ListItemsSignUp> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: ListTile(
        tileColor: const Color(0xFF292839),
        selectedTileColor: const Color(0xFF292839),
        leading: isSelected
            ? const Icon(
                Icons.check_circle_outline,
              )
            : const Icon(
                Icons.circle_outlined,
              ),
        selected: isSelected ? true : false,
        selectedColor: const Color(0xFF6AA71A),
        iconColor: Colors.grey,
        onTap: () {
          setState(() {
            isSelected = !isSelected;
            widget.isSelected!(isSelected);
          });
        },
        horizontalTitleGap: 0,
        dense: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        title: AutoSizeText(
          widget.item!["title"].toString(),
          maxLines: 1,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: AutoSizeText(
            widget.item!["description"].toString(),
            style: const TextStyle(color: Colors.white),
            maxLines: 2,
          ),
        ),
        contentPadding: const EdgeInsets.all(12),
      ),
    );
  }
}
