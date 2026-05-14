import 'package:flutter/material.dart';
import 'package:june/Widgets/DateSlider/date_slider_item.dart';

class DateSlider extends StatefulWidget {
  const DateSlider({super.key});

  @override
  State<DateSlider> createState() => _DateSliderState();
}

class _DateSliderState extends State<DateSlider> {
  DateTime selectedDate = DateTime.now();
  List<DateTime> weekdays = [];
  
  @override
  void initState() {
    super.initState();
    weekdays = entireWeekDays();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90, 
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weekdays.length,
        itemBuilder: (context, index) {
          final date = weekdays[index];
          // Check if this specific item is the selected one
          final isSelected = date.year == selectedDate.year &&
                             date.month == selectedDate.month &&
                             date.day == selectedDate.day;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = date;
              });
            },
            // Wrap in a container to give padding between items
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: DateSliderItem(date: date, isSelected: isSelected),
            ),
          );
        },
      ),
    );
  }

  static List<DateTime> entireWeekDays() {
    List<DateTime> dates = [];

    DateTime today = DateTime.now();
    
    // 2. Calculate how many days have passed since Monday
    // In Dart, weekday 1 is Monday, 2 is Tuesday, etc.
    int daysSinceMonday = today.weekday - 1;
    
    // 3. Subtract those days to get the exact date of this week's Monday
    DateTime monday = today.subtract(Duration(days: daysSinceMonday));

    // 4. Generate exactly 7 days starting from that Monday
    dates = List.generate(
      7, 
      (index) => monday.add(Duration(days: index)),
    );

    return dates;
  }
}