// ignore_for_file: unrelated_type_equality_checks

import 'package:ffadvertisement/catagories/catagories.dart';
import 'package:ffadvertisement/component/bottomNavigation.dart';
import 'package:ffadvertisement/home/home_index.dart';
import 'package:ffadvertisement/notification/notification.dart';
import 'package:ffadvertisement/settings/settings.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AppState();
}

enum TabItem { home, catagories, notification, setting }

class AppState extends State<App> {
  TabItem currentTab = TabItem.home;

  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.catagories: GlobalKey<NavigatorState>(),
    TabItem.notification: GlobalKey<NavigatorState>(),
    TabItem.setting: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem) {
    setState(() {
      currentTab = tabItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await navigatorKeys[currentTab]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (currentTab != TabItem.home) {
            // select 'main' tab
            _selectTab(TabItem.home);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Stack(
          children: [
            _buildOff(currentTab),
          ],
        ),
        // Bottom navigation
        bottomNavigationBar: BottomNavigation(
          currentTab: currentTab.index,
          selectTab: (index) => _selectTab(
            TabItem.values[index],
          ),
        ),
      ),
    );
  }

  Widget _buildOff(TabItem tabItem) {
    return Offstage(
      offstage: currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: navigatorKeys[tabItem],
        tabItem: tabItem.name,
      ),
    );
  }
}

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState>? navigatorKey;
  final String? tabItem;

  const TabNavigator({
    super.key,
    this.navigatorKey,
    this.tabItem,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = Container();
    if (tabItem == "home") {
      child = const HomePageContent();
    }
    else if (tabItem == "catagories") {
      child = const CategoriesList();
    }
    else if (tabItem == "notification") {
      child = const NotificationPage();
    }
    else if (tabItem == "setting") {
      child = const SettingPage();
    }
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
