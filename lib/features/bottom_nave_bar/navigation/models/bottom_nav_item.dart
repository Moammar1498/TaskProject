import 'package:flutter/material.dart';

class BottomNavItem {
  final IconData icon;
  final String route;
  final bool isSelected;

  BottomNavItem({
    required this.icon,
    required this.route,
    required this.isSelected,
  });

  BottomNavItem copyWith({
    IconData? icon,
    String? route,
    bool? isSelected,
  }) {
    return BottomNavItem(
      icon: icon ?? this.icon,
      route: route ?? this.route,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
