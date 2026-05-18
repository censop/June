import 'package:flutter/material.dart';
import 'package:june/Widgets/Screens/app_shell.dart';
import 'package:june/Widgets/Pages/Authentication/forgot_password_page.dart';
import 'package:june/Widgets/Pages/Authentication/sign_in_page.dart';
import 'package:june/Widgets/Screens/sign_up_screen.dart';
import 'package:june/Widgets/Theme/my_theme.dart';
import 'package:june/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: 'https://dbfmxblmzlelgixekokn.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRiZm14YmxtemxlbGdpeGVrb2tuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg3NjE5MDQsImV4cCI6MjA5NDMzNzkwNH0.DqSAWi9fJh8LzKRDM_4MGFy3iAC8xIDuxz8cwwZnQQk',
  );
  
  runApp(const MyApp());
}

// Global helper — use this anywhere in your app
final supabase = Supabase.instance.client;

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();


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
      home: StreamBuilder<AuthState>(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final session = snapshot.data!.session;
            if (session != null) {
              return const AppShell(initialIndex: 2);
            }
          }
          return const SignUpScreen();
        },
      ),
      routes: {
        Routes.homePage: (context) => const AppShell(initialIndex: 0),
        Routes.signUpPage: (context) => const SignUpScreen(),
        Routes.signInPage: (context) => const SignInPage(),
        Routes.forgotPasswordPage: (context) => const ForgotPasswordPage(),
        Routes.schedulePage: (context) => const AppShell(initialIndex: 2),
        Routes.aiChatPage: (context) => const AppShell(initialIndex: 3),
      },
      theme: MyTheme.lightTheme,
    );
  }
}
