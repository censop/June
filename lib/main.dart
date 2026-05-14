import 'package:flutter/material.dart';
import 'package:june/Widgets/Screens/app_shell.dart';
import 'package:june/Widgets/Screens/sign_up_screen.dart';
import 'package:june/Widgets/Theme/my_theme.dart';
import 'package:june/routes.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() {
  runApp(const MyApp());
}

class _NoBounceBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const ClampingScrollPhysics();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "June",
      navigatorObservers: [routeObserver],
      scrollBehavior: _NoBounceBehavior(),
      home: const AppShell(),
      routes: {
        Routes.homePage: (context) => const AppShell(initialIndex: 0),
        Routes.signUpPage: (context) => const SignUpScreen(),
        Routes.schedulePage: (context) => const AppShell(initialIndex: 3),
        Routes.aiChatPage: (context) => const AppShell(initialIndex: 4),
      },
      theme: MyTheme.lightTheme,
    );
  }
}
