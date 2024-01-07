import 'package:flutter/material.dart';
import 'package:taskproject/features/bottom_nave_bar/navigation/models/bottom_nav_item.dart';

abstract class INavigationRepository {
  List<BottomNavItem> getDefaultNavItems();
}

class NavigationRepository extends INavigationRepository {
  @override
  List<BottomNavItem> getDefaultNavItems() {
    return [
      BottomNavItem(
        icon: Icons.home_outlined,
        route: 'home',
        isSelected: true,
      ),
      BottomNavItem(
        icon: Icons.calendar_month_outlined,
        route: 'calender',
        isSelected: true,
      ),
      BottomNavItem(
        icon: Icons.notifications_outlined,
        route: 'notification',
        isSelected: true,
      ),
      BottomNavItem(
        icon: Icons.person_outline_outlined,
        route: 'profile',
        isSelected: true,
      ),
    ];
  }
}
