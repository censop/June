import 'package:flutter/material.dart';

class AppPreferencesPage extends StatefulWidget {
  const AppPreferencesPage({super.key});

  @override
  State<AppPreferencesPage> createState() => _AppPreferencesPageState();
}

class _AppPreferencesPageState extends State<AppPreferencesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( //can make it a seperate widget
        title: Text("App Preferences"),
        backgroundColor: Colors.white,
        elevation: 3,
        shadowColor: Colors.black.withAlpha(30), 
        surfaceTintColor: Colors.transparent, 
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Theme.of(context).colorScheme.tertiary.withAlpha(120), 
            height: 1.0, 
          ),
        ),
      ),
      body: Row(

      ),
    );
  }
}