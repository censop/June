import 'package:flutter/material.dart';
import 'package:june/Widgets/Screens/home_page.dart';
import 'package:june/Widgets/Screens/schedule_new.dart';
import 'package:june/Widgets/Screens/sign_up_screen.dart';
import 'package:june/Widgets/Theme/my_theme.dart';
import 'package:june/routes.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() {      
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "June",
      navigatorObservers: [routeObserver],
      home: const ScheduleNew(),
      routes: {
        Routes.homePage: (context) => const HomePage(),
        Routes.signUpPage: (context) => const SignUpScreen(),
        Routes.schedulePage: (context) => const ScheduleNew(),
      },
      theme: MyTheme.lightTheme,
    );
  }
}
