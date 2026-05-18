import 'package:flutter/material.dart' hide DateUtils;
import 'package:june/Models/task.dart';
import 'package:june/Widgets/Cards/custom_default_card.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late bool _completed;

  @override
  void initState() {
    super.initState();
    _completed = widget.task.isCompleted;
  }

  String _fmtTime(DateTime dt) {
    final hour = dt.hour == 0
        ? 12
        : dt.hour > 12
            ? dt.hour - 12
            : dt.hour;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final start = _fmtTime(widget.task.startsAt);
    final end = _fmtTime(widget.task.endsAt);

    return CustomDefaultCard(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 4,
                height: double.infinity,
                color: Colors.amber,
              ),
              Checkbox(
                value: _completed,
                shape: const CircleBorder(),
                onChanged: (v) => setState(() => _completed = v ?? false),
                side: BorderSide(
                  width: 0.7,
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(100),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.title,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              Text(
                '$start -\n$end',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isCurrentTask() {
    final now = DateTime.now();
    final isToday = widget.task.startsAt.year == now.year &&
        widget.task.startsAt.month == now.month &&
        widget.task.startsAt.day == now.day;
    if (!isToday) return false;
    final startMinutes =
        widget.task.startsAt.hour * 60 + widget.task.startsAt.minute;
    final endMinutes =
        widget.task.endsAt.hour * 60 + widget.task.endsAt.minute;
    final nowMinutes = now.hour * 60 + now.minute;
    return nowMinutes >= startMinutes && nowMinutes <= endMinutes;
  }
}
