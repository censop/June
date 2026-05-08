import 'package:flutter/material.dart';
import 'package:june/Models/day.dart';
import 'package:june/Models/task.dart';
import 'package:june/Widgets/Buttons/custom_primary_elevated_button.dart';
import 'package:june/Widgets/Cards/day_card.dart';
import 'package:june/Widgets/Cards/task_card.dart';
import 'package:june/Widgets/Form/custom_text_form_field.dart';
import 'package:june/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar( //can make it a seperate widget
        title: Text("June Logo Placeholder"),
        backgroundColor: Colors.white,
        elevation: 3,
        shadowColor: Colors.black.withAlpha(30), 
        surfaceTintColor: Colors.transparent, 
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Theme.of(context).colorScheme.tertiary.withAlpha(120), 
            height: 1.0, 
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: Icon(Icons.tune) 
          ),
          IconButton(
            onPressed: () {}, 
            icon: Icon(Icons.settings)
          )
        ],
      ),
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
              "Friday, June 12",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(100)
              ),
            ),
            SizedBox(height: 16,),
            TaskCard(task: dummyTask,),
            DayCard(day: day),
            CustomTextFormField(),
            CustomElevatedPrimaryButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.signUpPage);
              }, 
              text: "lala"
            )
          ] 
        ),
      ),
    );
  }


  //DUMMY TASK FOR TEST 
  Task dummyTask = Task(taskName: "Study block", description: "Tessst", startTime: TimeOfDay(hour: 11, minute: 30), endTime: TimeOfDay(hour: 15, minute: 30));
  late Day day = Day(date: DateTime.now(), tasks: [Task(taskName: "Study block", description: "Tessst", startTime: TimeOfDay(hour: 11, minute: 30), endTime: TimeOfDay(hour: 15, minute: 30)), Task(taskName: "Do stuff", description: "Tessst", startTime: TimeOfDay(hour: 11, minute: 30), endTime: TimeOfDay(hour: 15, minute: 30))]);
}