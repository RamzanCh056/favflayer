// import 'package:flutter/material.dart';

// import '../home/home_index.dart';
// import '../notification/notification.dart';
// import '../settings/settings.dart';
// class MyNavigation extends StatefulWidget {
//   const MyNavigation({Key? key}) : super(key: key);

//   @override
//   State<MyNavigation> createState() => _MyNavigationState();
// }

// class _MyNavigationState extends State<MyNavigation>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabcontroller;

//   int _selectedIndex = 0;
//   List<Widget> pages = [
//     HomePageContent(),
//     NotificationPage(),
//     SettingPage(),
//   ];
//   @override
//   void initState() {
//     // TODO: implement initState
//     _tabcontroller = TabController(length: 3, vsync: this);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _tabcontroller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: pages[_selectedIndex],
//       ),

//       bottomNavigationBar: TabBar(
//         onTap: (index) {
//           _selectedIndex = index;
//           setState(() {});
//         },
//         //overlayColor:MaterialStateProperty.all(Colors.green),
//         controller: _tabcontroller,
//         labelPadding: EdgeInsets.zero,
//         labelColor: Color(0xFF0C331F),
//         padding: EdgeInsets.zero,

//         unselectedLabelColor: Color(0xFF747474),
//         indicatorSize: TabBarIndicatorSize.label,
//         unselectedLabelStyle: TextStyle(fontSize: 12),
//         labelStyle: TextStyle(),


//         //   unselectedIconSize: 25,

//         indicator: UnderlineTabIndicator(
//             borderSide: BorderSide(color: Color(0xFFFBC947), width: 3.0),
//             insets: EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 71.0)),
//         tabs: [
//           Tab(
//             iconMargin: EdgeInsets.only(top: 8),
//             icon: Image.asset(
//               "assets/ios-awesome-home.png",
//               color: _tabcontroller.index == 0
//                   ? Color(0xFF0C331F)
//                   : Color(0xFF747474),
//               width: 25,
//             ),
//             child: Padding(
//               padding: const EdgeInsets.only(top: 6.0, bottom: 10),
//               child: Text(
//                 'Home',
//               ),
//             ),
//           ),
//           Tab(
//             iconMargin: EdgeInsets.only(top: 8),
//             icon: Image.asset(
//               "assets/ios-notifications.png",
//               color: _tabcontroller.index == 1
//                   ? Color(0xFF0C331F)
//                   : Color(0xFF747474),
//               width: 25,
//             ),
//             child: Padding(
//               padding: const EdgeInsets.only(top: 6.0, bottom: 10),
//               child: Text(
//                 'Notifications',
//               ),
//             ),
//           ),
//           Tab(
//             iconMargin: EdgeInsets.only(top: 8),
//             icon: Image.asset(
//               "assets/ios-settings.png",
//               color: _tabcontroller.index == 2
//                   ? Color(0xFF0C331F)
//                   : Color(0xFF747474),
//               width: 25,
//             ),
//             child: Padding(
//               padding: const EdgeInsets.only(top: 6.0, bottom: 10),
//               child: Text(
//                 'Settings',
//               ),
//             ),
//           ),

//         ],
//       ),
//     );
//   }
// }