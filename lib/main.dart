import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskproject/features/auth/login_screen.dart';
import 'package:taskproject/features/auth/register_screen.dart';
import 'package:taskproject/features/bottom_nave_bar/bottom_nav_shell.dart';
import 'package:taskproject/features/bottom_nave_bar/providers/bottom_navigation.viewmodel.dart';
import 'package:taskproject/utils/colors.dart';
import 'package:taskproject/utils/keys.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NavItemProvider())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
            useMaterial3: true,
          ),
          initialRoute: '/login',
          navigatorKey: AppKeys.mainAppNav,
          routes: {
            '/login': (context) => const LoginScreen(),
            '/register': (context) => const RegisterScreen(),
            '/home': (context) => const BottomNavShell(),
          }),
    );
  }
}
