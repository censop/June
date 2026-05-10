import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( //can make it a seperate widget
        title: Text("Settings"),
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
    );
  }
}