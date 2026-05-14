import 'package:flutter/material.dart';
import 'package:june/Widgets/Schedule/schedule_assistant_sheet.dart';
import 'package:june/Widgets/Schedule/schedule_body.dart';
import 'package:june/Widgets/Theme/my_theme.dart';

class ScheduleNew extends StatelessWidget {
  const ScheduleNew({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.scheduleBg,
      body: const SafeArea(child: ScheduleBody()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog<void>(
          context: context,
          barrierColor: Colors.black.withAlpha(60),
          builder: (_) => const ScheduleAssistantSheet(),
        ),
        backgroundColor: MyTheme.scheduleFab,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(Icons.auto_fix_high_rounded, size: 24),
      ),
    );
  }
}
