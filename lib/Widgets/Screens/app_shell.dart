import 'package:flutter/material.dart';
import 'package:june/Widgets/Screens/ai_chat_screen.dart';
import 'package:june/Widgets/Pages/NavigationBar/old_home_page.dart';
import 'package:june/Widgets/Screens/schedule_new_home.dart';
import 'package:june/Widgets/Theme/my_theme.dart';

class AppShell extends StatefulWidget {
  final int initialIndex;

  const AppShell({super.key, this.initialIndex = 2});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  static const _pages = <Widget>[
    HomePage(),
    _PlaceholderPage(label: 'Tasks'),
    ScheduleNew(),
    AiChatScreen(),
  ];

  static const _titles = ['Dashboard', 'Tasks', 'Schedule', 'AI Assistant'];

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.surfaceContainerLowest,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: Icon(Icons.menu_rounded, color: MyTheme.onSurfaceVariantColor, size: 22),
        titleSpacing: MyTheme.spaceSm,
        title: Text(
          _titles[_currentIndex],
          style: tt.titleLarge?.copyWith(color: MyTheme.primaryColor),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: MyTheme.outlineVariantColor.withValues(alpha: 0.5),
            height: 1.0,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: MyTheme.spaceMd),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: MyTheme.primaryColor.withValues(alpha: 0.12),
              child: Text(
                'B',
                style: tt.labelLarge?.copyWith(
                  color: MyTheme.primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: MyTheme.signUpTeal,
        unselectedItemColor: MyTheme.signUpSubtitle,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_rounded),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome_outlined),
            label: 'AI',
          ),
        ],
      ),
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  final String label;

  const _PlaceholderPage({required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.scheduleBg,
      body: Center(
        child: Text(label, style: Theme.of(context).textTheme.headlineMedium),
      ),
    );
  }
}
