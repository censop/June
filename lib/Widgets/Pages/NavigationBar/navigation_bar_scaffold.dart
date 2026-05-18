import 'package:flutter/material.dart';
import 'package:june/Widgets/Pages/NavigationBar/old_home_page.dart';
import 'package:june/Widgets/Pages/NavigationBar/settings_page.dart';

class NavigationBarScaffold extends StatefulWidget {
  const NavigationBarScaffold({super.key});

  @override
  State<NavigationBarScaffold> createState() => _NavigationBarScaffoldState();
}

class _NavigationBarScaffoldState extends State<NavigationBarScaffold> {
  int _currentPageIndex = 0;

  List<Widget> pages = [
    const HomePage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(30), 
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: NavigationBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          onDestinationSelected: (int index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
          selectedIndex: _currentPageIndex,
          indicatorColor: Theme.of(context).colorScheme.surface,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      ),
      body: pages[_currentPageIndex],
    );
  }
}