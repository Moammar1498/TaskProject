import 'package:flutter/material.dart';
import 'package:taskproject/features/bottom_nave_bar/navigation/models/bottom_nav_item.dart';
import 'package:taskproject/utils/keys.dart';

class NavItemProvider with ChangeNotifier {
  String? tabSelection = 'home';

  void setTabSelection(BottomNavItem item) {
    AppKeys.mainListNav.currentState
        ?.pushReplacementNamed('/${item.route.toLowerCase()}');
    tabSelection = item.route;
    notifyListeners();
  }
}
