import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:june/Models/task.dart';
import 'package:june/Widgets/Cards/task_card.dart';
import 'package:june/Widgets/DateSlider/date_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String todayString;
  final List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    todayString = getTodayString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good Morning, CANSU",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              todayString,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(100),
              ),
            ),
            const SizedBox(height: 20),
            const DateSlider(),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return TaskCard(task: tasks[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  String getTodayString() {
    return DateFormat('EEEE, MMMM d').format(DateTime.now());
  }
}
