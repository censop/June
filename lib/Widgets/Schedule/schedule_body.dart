import 'package:flutter/material.dart';
import 'package:june/Models/day.dart';
import 'package:june/Models/task.dart';
import 'package:june/Services/task_service.dart';
import 'package:june/Widgets/Schedule/schedule_header.dart';
import 'package:june/Widgets/Schedule/welcome.dart';
import 'package:june/Widgets/Schedule/schedule_task_card.dart';
import 'package:june/Widgets/Schedule/week_day_strip.dart';
import 'package:june/Widgets/Theme/my_theme.dart';

class ScheduleBody extends StatefulWidget {
  const ScheduleBody({super.key});

  @override
  State<ScheduleBody> createState() => _ScheduleBodyState();
}

class _ScheduleBodyState extends State<ScheduleBody> {
  static const int _daysBefore = 14;
  static const int _totalDays = 60;

  late final List<Day> _days;
  late int _selectedIndex;
  List<Task> _tasks = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    final start = today.subtract(const Duration(days: _daysBefore));
    _days = List.generate(
      _totalDays,
      (i) => Day(date: start.add(Duration(days: i))),
    );
    _selectedIndex = _daysBefore;
    _loadTasks();
  }

  DateTime get _selectedDay => _days[_selectedIndex].date;

  Future<void> _loadTasks() async {
    setState(() => _isLoading = true);
    try {
      final tasks = await TaskService.fetchForDate(_selectedDay);
      if (mounted) setState(() => _tasks = tasks);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _toggleCompletion(Task task, bool completed) async {
    final newStatus = completed ? 'completed' : 'pending';
    await TaskService.updateStatus(task.id, newStatus);
    await _loadTasks();
  }

  Color _accentColor(Task task) =>
      task.isCompleted ? MyTheme.signUpTeal : MyTheme.primaryColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: MyTheme.spaceLg),
        const Welcome(username: 'Beliz'),
        const SizedBox(height: MyTheme.spaceLg),
        WeekDayStrip(
          days: _days,
          selectedIndex: _selectedIndex,
          onDaySelected: (i) {
            setState(() => _selectedIndex = i);
            _loadTasks();
          },
        ),
        const SizedBox(height: MyTheme.spaceMd),
        ScheduleHeader(
          selectedDate: _selectedDay,
          onTaskCreated: _loadTasks,
        ),
        const SizedBox(height: MyTheme.spaceMd),
        Expanded(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: MyTheme.spaceXl),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (_tasks.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: MyTheme.spaceXl,
                      horizontal: MyTheme.spaceMd,
                    ),
                    child: Center(
                      child: Text(
                        'No tasks for this day.\nTap + to add one.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: MyTheme.outlineColor,
                            ),
                      ),
                    ),
                  )
                else
                  for (var i = 0; i < _tasks.length; i++) ...[
                    if (i > 0) const SizedBox(height: MyTheme.spaceSm),
                    ScheduleTaskCard(
                      key: ValueKey(_tasks[i].id),
                      taskId: _tasks[i].id,
                      taskDate: _selectedDay,
                      title: _tasks[i].title,
                      timeRange: _tasks[i].timeRange,
                      accentColor: _accentColor(_tasks[i]),
                      initialCompleted: _tasks[i].isCompleted,
                      onCompletionChanged: (completed) =>
                          _toggleCompletion(_tasks[i], completed),
                      onTaskChanged: _loadTasks,
                    ),
                  ],
                const SizedBox(height: MyTheme.spaceMd),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
