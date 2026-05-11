import 'package:flutter/material.dart';
import 'package:june/Widgets/DateSlider/date_slider_item.dart';

class DateSlider extends StatefulWidget {
  const DateSlider({super.key});

  @override
  State<DateSlider> createState() => _DateSliderState();
}

class _DateSliderState extends State<DateSlider> {
  DateTime _selectedDate = DateTime.now();
  
  // 2. Generate a list of dates (e.g., 14 days starting from today)
  final List<DateTime> _dates = List.generate(
    7, 
    (index) => DateTime.now().add(Duration(days: index)),
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90, // Fixed height for the slider
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _dates.length,
        itemBuilder: (context, index) {
          final date = _dates[index];
          // Check if this specific item is the selected one
          final isSelected = date.year == _selectedDate.year &&
                             date.month == _selectedDate.month &&
                             date.day == _selectedDate.day;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = date;
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
}