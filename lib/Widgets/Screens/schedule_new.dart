import 'package:flutter/material.dart';
import 'package:june/Models/day.dart';
import 'package:june/Widgets/Schedule/schedule_bottom_nav.dart';
import 'package:june/Widgets/Schedule/schedule_task_card.dart';
import 'package:june/Widgets/Schedule/week_day_strip.dart';
import 'package:june/Widgets/Theme/my_theme.dart';

// 31 days starting May 1 — initial selection is May 14 (index 13)
final _days = List.generate(31, (i) => Day(date: DateTime(2025, 5, 1 + i)));

class ScheduleNew extends StatefulWidget {
  const ScheduleNew({super.key});

  @override
  State<ScheduleNew> createState() => _ScheduleNewState();
}

class _ScheduleNewState extends State<ScheduleNew> {
  int _selectedIndex = 13;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.scheduleBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AppBar(),
            const SizedBox(height: 20),
            _ScheduleHeader(),
            const SizedBox(height: 20),
            WeekDayStrip(
              days: _days,
              selectedIndex: _selectedIndex,
              onDaySelected: (i) => setState(() => _selectedIndex = i),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Card 1 — Deep Focus
                    ScheduleTaskCard(
                      title: 'Architecture Review',
                      timeRange: '08:00 -\n10:00',
                      accentColor: MyTheme.schedulePurple,
                      cardBg: MyTheme.scheduleCardTint,
                      badge: 'DEEP FOCUS',
                      badgeColor: MyTheme.signUpTeal,
                      showDot: true,
                      description:
                          'Finalizing the structural integrity of\nthe Core API',
                    ),
                    const SizedBox(height: 12),
                    // Card 2 — Sync with Design Team
                    ScheduleTaskCard(
                      title: 'Sync with Design\nTeam',
                      timeRange: '10:00 -\n11:00',
                      accentColor: MyTheme.signUpTeal,
                      status: 'In Progress',
                      statusColor: MyTheme.signUpTeal,
                      icon: Icons.group_outlined,
                    ),
                    const SizedBox(height: 12),
                    // Card 3 — Documentation Update
                    ScheduleTaskCard(
                      title: 'Documentation\nUpdate',
                      timeRange: '11:00 -\n12:00',
                      accentColor: MyTheme.signUpSubtitle,
                      status: 'Next Up',
                      timeChip: '11:15',
                      icon: Icons.edit_note_rounded,
                    ),
                    const SizedBox(height: 28),
                    _BlockTimeCTA(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: MyTheme.scheduleFab,
        elevation: 4,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      bottomNavigationBar: const ScheduleBottomNav(activeIndex: 3),
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          Icon(Icons.menu_rounded, color: MyTheme.neutralColor, size: 24),
          const SizedBox(width: 12),
          Text(
            'FocusFlow',
            style: theme.textTheme.titleLarge?.copyWith(
              color: MyTheme.signUpTeal,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Spacer(),
          CircleAvatar(
            radius: 18,
            backgroundColor: MyTheme.signUpTeal,
            child: const Icon(Icons.person, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }
}

class _ScheduleHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Schedule',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const Spacer(),
          Icon(Icons.chevron_left, color: MyTheme.signUpTeal, size: 22),
          const SizedBox(width: 6),
          Text(
            'Today',
            style: theme.textTheme.labelMedium?.copyWith(
              color: MyTheme.neutralColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 6),
          Icon(Icons.chevron_right, color: MyTheme.signUpTeal, size: 22),
        ],
      ),
    );
  }
}

class _BlockTimeCTA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: TextButton.icon(
        onPressed: () {},
        icon: Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: MyTheme.signUpSubtitle, width: 1.5),
          ),
          child: Icon(Icons.add, size: 14, color: MyTheme.signUpSubtitle),
        ),
        label: Text(
          'BLOCK TIME FOR LUNCH',
          style: theme.textTheme.labelLarge?.copyWith(
            color: MyTheme.signUpSubtitle,
          ),
        ),
      ),
    );
  }
}
