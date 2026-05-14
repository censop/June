import 'package:flutter/material.dart';
import 'package:june/Models/day.dart';
import 'package:june/Widgets/Schedule/block_time_cta.dart';
import 'package:june/Widgets/Schedule/schedule_app_bar.dart';
import 'package:june/Widgets/Schedule/schedule_header.dart';
import 'package:june/Widgets/Schedule/welcome.dart';
import 'package:june/Widgets/Schedule/schedule_task_card.dart';
import 'package:june/Widgets/Schedule/week_day_strip.dart';
import 'package:june/Widgets/Theme/my_theme.dart';

final _days = List.generate(31, (i) => Day(date: DateTime(2025, 5, 1 + i)));

class ScheduleBody extends StatefulWidget {
  const ScheduleBody({super.key});

  @override
  State<ScheduleBody> createState() => _ScheduleBodyState();
}

class _ScheduleBodyState extends State<ScheduleBody> {
  int _selectedIndex = 13;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ScheduleAppBar(),
        const SizedBox(height: MyTheme.spaceLg),
        const Welcome(username: 'Beliz'),
        const SizedBox(height: MyTheme.spaceLg),
        WeekDayStrip(
          days: _days,
          selectedIndex: _selectedIndex,
          onDaySelected: (i) => setState(() => _selectedIndex = i),
        ),
        const SizedBox(height: MyTheme.spaceMd),
        const ScheduleHeader(),
        const SizedBox(height: MyTheme.spaceMd),
        Expanded(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScheduleTaskCard(
                  title: 'Architecture Review',
                  timeRange: '8:00 AM – 10:00 AM',
                  accentColor: MyTheme.schedulePurple,
                  subtasks: const [
                    'Define system boundaries',
                    'Review API contracts',
                    'Document decisions',
                  ],
                ),
                const SizedBox(height: MyTheme.spaceSm),
                ScheduleTaskCard(
                  title: 'Sync with Design Team',
                  timeRange: '10:00 AM – 11:00 AM',
                  accentColor: MyTheme.signUpTeal,
                  subtasks: const [
                    'Review new components',
                    'Align on spacing tokens',
                  ],
                  initialImpact: ImpactLevel.low,
                ),
                const SizedBox(height: MyTheme.spaceSm),
                ScheduleTaskCard(
                  title: 'Documentation Update',
                  timeRange: '11:00 AM – 12:00 PM',
                  accentColor: MyTheme.signUpSubtitle,
                  subtasks: const [
                    'Update API docs',
                    'Write changelog',
                  ],
                  initialImpact: ImpactLevel.low,
                ),
                const SizedBox(height: MyTheme.spaceMd),
                const BlockTimeCta(),
                const SizedBox(height: MyTheme.spaceMd),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
