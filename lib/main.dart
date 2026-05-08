import 'package:flutter/material.dart';
import 'package:june/Widgets/Screens/app_preferences_page.dart';
import 'package:june/Widgets/Screens/home_page.dart';
import 'package:june/Widgets/Screens/settings_page.dart';
import 'package:june/Widgets/Screens/sign_in_page.dart';
import 'package:june/Widgets/Screens/sign_up_page.dart';
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
      home: HomePage(), //placeholder until sign in implemented
      routes: {
        Routes.homePage : (context) => HomePage(),
        Routes.signUpPage : (context) => SignUpPage(),
        Routes.signInPage : (context) => SignInPage(),
        Routes.appPrefPage : (context) => AppPreferencesPage(),
        Routes.settingsPage : (context) => SettingsPage()
      },
      theme: MyTheme.lightTheme,
    );
  }
}
