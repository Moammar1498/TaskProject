import 'package:taskproject/features/bottom_nave_bar/navigation/models/bottom_nav_item.dart';

abstract class INavigationRepository {
  List<BottomNavItem> getDefaultNavItems();
}

class NavigationRepository extends INavigationRepository {
  @override
  List<BottomNavItem> getDefaultNavItems() {
    return [
      BottomNavItem(
        iconSrc: 'assets/images/home.png',
        route: 'home',
        isSelected: true,
      ),
      BottomNavItem(
        iconSrc: 'assets/images/calendar.png',
        route: 'calender',
        isSelected: true,
      ),
      BottomNavItem(
        iconSrc: 'assets/images/notification.png',
        route: 'notification',
        isSelected: true,
      ),
      BottomNavItem(
        iconSrc: 'assets/images/profile.png',
        route: 'profile',
        isSelected: true,
      ),
    ];
  }
}
