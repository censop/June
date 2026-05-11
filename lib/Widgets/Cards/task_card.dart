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

  @override
  Widget build(BuildContext context) {
    final String start = widget.task.startTime.format(context);
    final String end = widget.task.endTime.format(context);

    return CustomDefaultCard(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16,24,16,24),
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.max ,  
            children: [
              Container(
                width: 4, // Give it a width
                height: double.infinity, //
                color: Colors.amber//isCurrentTask() ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.tertiary
              ),
              Checkbox(
                value: widget.task.isCompleted, 
                shape: CircleBorder(),
                onChanged: (isChanged) {
                  setState(() {
                    widget.task.isCompleted = isChanged ?? false;
                  });
                },
                side: BorderSide(
                  width: 0.7,
                  color:Theme.of(context).colorScheme.onSurface.withAlpha(100) 
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.taskName,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      widget.task.description != "" ? widget.task.description : "No description.",
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withAlpha(150)
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "$start - \n $end",
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(150)
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
    
    final isToday = widget.task.date.year == now.year &&
                    widget.task.date.month == now.month &&
                    widget.task.date.day == now.day;

    if (!isToday) return false; 

    final startMinutes = widget.task.startTime.hour * 60 + widget.task.startTime.minute;
    final endMinutes = widget.task.endTime.hour * 60 + widget.task.endTime.minute;
    final nowMinutes = now.hour * 60 + now.minute;
    return nowMinutes >= startMinutes && nowMinutes <= endMinutes;
  }
}