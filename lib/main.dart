import 'package:flutter/material.dart';
import 'package:june/Widgets/Pages/NavigationBar/navigation_bar_scaffold.dart';
import 'package:june/Widgets/Pages/app_preferences_page.dart';
import 'package:june/Widgets/Pages/forgot_password_page.dart';
import 'package:june/Widgets/Pages/NavigationBar/home_page.dart';
import 'package:june/Widgets/Pages/NavigationBar/settings_page.dart';
import 'package:june/Widgets/Pages/sign_in_page.dart';
import 'package:june/Widgets/Pages/sign_up_page.dart';
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
      home: NavigationBarScaffold(), //placeholder until sign in implemented
      routes: {
        Routes.homePage : (context) => HomePage(),
        Routes.signUpPage : (context) => SignUpPage(),
        Routes.signInPage : (context) => SignInPage(),
        Routes.appPrefPage : (context) => AppPreferencesPage(),
        Routes.settingsPage : (context) => SettingsPage(),
        Routes.forgotPasswordPage : (context) => ForgotPasswordPage()
      },
      theme: MyTheme.lightTheme,
    );
  }
}
