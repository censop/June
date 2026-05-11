import 'package:flutter/material.dart';

class DayUtils {
  static TimeOfDay stringToTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    if (parts.length != 2) return TimeOfDay(hour: 0, minute: 0);
    
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  /// string should be hh:mm
  static String timeOfDayToString(TimeOfDay time) {
    final String h = time.hour.toString().padLeft(2, '0');
    final String m = time.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  static String getTodayForDatabase() {
    final now = DateTime.now();
    final String y = now.year.toString();
    final String m = now.month.toString().padLeft(2, '0');
    final String d = now.day.toString().padLeft(2, '0');
    
    return '$y-$m-$d';
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
