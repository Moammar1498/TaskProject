// ignore_for_file: public_member_api_docs, sort_constructors_first

class BottomNavItem {
  final String iconSrc;
  final String route;
  final bool isSelected;
  BottomNavItem({
    required this.iconSrc,
    required this.route,
    required this.isSelected,
  });

  BottomNavItem copyWith({
    String? iconSrc,
    String? route,
    bool? isSelected,
  }) {
    return BottomNavItem(
      iconSrc: iconSrc ?? this.iconSrc,
      route: route ?? this.route,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
