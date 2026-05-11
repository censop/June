import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:june/Models/day.dart';
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

  late List<Task> tasks = [ //DUMMY TASK
    Task(taskName: "Study block", description: "Tessst", startTime: TimeOfDay(hour: 11, minute: 30), endTime: TimeOfDay(hour: 15, minute: 30))
  ];

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
          mainAxisSize:  MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Text(
              "Good Morning, CANSU",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text( //will not be like this when database is loaded
              todayString,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(100)
              ),
            ),
            SizedBox(height: 20,),
            DateSlider(),
            SizedBox(height: 20,),
            ListView.builder(
              shrinkWrap: true,
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final Task currTask = tasks[index];

                return TaskCard(task: currTask);
              },
            ),
          ] 
        ),
      ),
    );
  }

  String getTodayString() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, MMMM d').format(now);

    return formattedDate;
  }


  //DUMMY TASK FOR TEST 
  Task dummyTask = Task(taskName: "Study block", description: "Tessst", startTime: TimeOfDay(hour: 11, minute: 30), endTime: TimeOfDay(hour: 15, minute: 30));
  late Day day = Day(date: DateTime.now(), tasks: [Task(taskName: "Study block", description: "Tessst", startTime: TimeOfDay(hour: 11, minute: 30), endTime: TimeOfDay(hour: 15, minute: 30)), Task(taskName: "Do stuff", description: "Tessst", startTime: TimeOfDay(hour: 11, minute: 30), endTime: TimeOfDay(hour: 15, minute: 30))]);
}