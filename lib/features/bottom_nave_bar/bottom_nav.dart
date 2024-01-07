import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskproject/features/bottom_nave_bar/navigation/models/bottom_nav_item.dart';
import 'package:taskproject/features/bottom_nave_bar/navigation/navigation_repo_i.dart';
import 'package:taskproject/features/bottom_nave_bar/providers/bottom_navigation.viewmodel.dart';
import 'package:taskproject/utils/colors.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    INavigationRepository navigationRepository = NavigationRepository();
    final navItems = navigationRepository.getDefaultNavItems();
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadius.all(Radius.circular(45))),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(navItems.length, (index) {
            return BottomNavTile(item: navItems[index]);
          }),
        ),
      ),
    );
  }
}

class BottomNavTile extends StatelessWidget {
  final BottomNavItem item;
  const BottomNavTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavItemProvider>(builder: (context, navItem, child) {
      return Column(
        children: [
          IconButton(
            onPressed: () {
              navItem.setTabSelection(item);
            },
            icon: Icon(
              item.icon,
              color: navItem.tabSelection == item.route
                  ? AppColors.primaryColor
                  : Colors.black,
            ),
          ),
          navItem.tabSelection == item.route
              ? const SizedBox(
                  width: 10,
                  height: 2,
                  child: ColoredBox(
                    color: AppColors.primaryColor,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      );
    });
  }
}
