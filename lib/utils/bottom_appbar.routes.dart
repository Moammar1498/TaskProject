import 'package:flutter/material.dart';
import 'package:taskproject/features/profile/Profile.dart';
import 'package:taskproject/features/home/home_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget page;
    switch (settings.name) {
      case '/home':
        page = const HomeScreen();
        break;
      case '/calender':
        page = const Center(
          child: Text('profile'),
        );
        break;
      case '/notification':
        page = const Center(
          child: Text('Notifications'),
        );
        break;
      case '/profile':
        page = const ProfilePage();
        break;
      default:
        page = const Center(
          child: Text('No Specified Route'),
        );
    }
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: const Duration(seconds: 0),
    );
  }
}
