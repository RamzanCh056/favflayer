// ignore_for_file: file_names, use_key_in_widget_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final int currentTab;
  final ValueChanged selectTab;
  const BottomNavigation({
    Key? key,
    required this.currentTab,
    required this.selectTab,
  }) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int ind = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).primaryColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: widget.selectTab,
      currentIndex: widget.currentTab,
      items: [
        BottomNavigationItem(
          "Home",
          Image.asset(
            "assets/ios-awesome-home.png",
            width: 30,
            height: 30,
          ),
          Image.asset(
            "assets/awesome-home.png",
            width: 30,
            height: 30,
          ),
        ),
        BottomNavigationItem(
          "Catagories",

          Icon(Icons.collections_outlined, color: Colors.green, size: 30,),
          Icon(Icons.collections, color: Colors.green, size: 30,),
          // Image.asset(
          //   "assets/ios-awesome-home.png",
          //   width: 30,
          //   height: 30,
          // ),
          // Image.asset(
          //   "assets/awesome-home.png",
          //   width: 30,
          //   height: 30,
          // ),
        ),
        BottomNavigationItem(
          "Notifications",
          Image.asset(
            "assets/ios-notifications.png",
            width: 30,
            height: 30,
          ),
          Image.asset(
            "assets/notifications-1.png",
            width: 30,
            height: 30,
          ),
        ),
        BottomNavigationItem(
          "Settings",
          Image.asset(
            "assets/ios-settings.png",
            width: 30,
            height: 30,
          ),
          Image.asset(
            "assets/settings.png",
            width: 30,
            height: 30,
          ),
        ),
      ],
    );
  }

  BottomNavigationBarItem BottomNavigationItem(
    String label,
    Widget icon,
    Widget activeIcon,
  ) {
    return BottomNavigationBarItem(
      label: label,
      icon: icon,
      activeIcon: activeIcon,
    );
  }
}
