import 'package:flutter/material.dart';
import 'package:june/Widgets/Schedule/new_task_sheet.dart';
import 'package:june/Widgets/Theme/my_theme.dart';

class ScheduleHeader extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onTaskCreated;

  const ScheduleHeader({
    super.key,
    required this.selectedDate,
    required this.onTaskCreated,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MyTheme.spaceMd),
      child: Row(
        children: [
          Text(
            'Schedule',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.calendar_month_outlined),
            color: MyTheme.signUpTeal,
            tooltip: 'Add to Google Calendar',
          ),
          IconButton(
            onPressed: () async {
              final created = await showNewTaskDialog(
                context,
                selectedDate: selectedDate,
              );
              if (created == true) onTaskCreated();
            },
            icon: const Icon(Icons.add_task),
            color: MyTheme.signUpTeal,
            tooltip: 'Add new task',
          ),
        ],
      ),
    );
  }
}
