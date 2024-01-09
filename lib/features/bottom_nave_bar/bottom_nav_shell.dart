import 'package:flutter/material.dart';
import 'package:taskproject/features/bottom_nave_bar/bottom_nav.dart';
import 'package:taskproject/utils/bottom_appbar.routes.dart';
import 'package:taskproject/utils/keys.dart';

class BottomNavShell extends StatelessWidget {
  const BottomNavShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Navigator(
            key: AppKeys.mainListNav,
            initialRoute: '/home',
            onGenerateRoute: (settings) => Routes.generateRoute(settings),
          ),
          const Positioned(
            bottom: 20,
            child: BottomNav(),
          ),
        ],
      ),
    );
  }
}
