import 'package:june/Models/task.dart';

class Day {
  final DateTime date;
  final List<Task> tasks; 

  Day({
    required this.date,
    this.tasks = const [], 
  });

  String get dayNumber => date.day.toString();

  String get shortName {
    switch (date.weekday) {
      case DateTime.monday: return 'MON';
      case DateTime.tuesday: return 'TUE';
      case DateTime.wednesday: return 'WED';
      case DateTime.thursday: return 'THU';
      case DateTime.friday: return 'FRI';
      case DateTime.saturday: return 'SAT';
      case DateTime.sunday: return 'SUN';
      default: return '';
    }
  }

  String get longName {
    switch (date.weekday) {
      case DateTime.monday: return 'Monday';
      case DateTime.tuesday: return 'Tuesday';
      case DateTime.wednesday: return 'Wednesday';
      case DateTime.thursday: return 'Thursday';
      case DateTime.friday: return 'Friday';
      case DateTime.saturday: return 'Saturday';
      case DateTime.sunday: return 'Sunday';
      default: return '';
    }
  }

  Day copyWith({
    DateTime? date,
    List<Task>? tasks,
  }) {
    return Day(
      date: date ?? this.date,
      tasks: tasks ?? this.tasks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(), 
      'tasks': tasks.map((task) => task.toMap()).toList(),
    };
  }

  factory Day.fromMap(Map<String, dynamic> map) {
    return Day(
      date: DateTime.parse(map['date']),
      tasks: List<Task>.from(
        (map['tasks'] ?? []).map((taskMap) => Task.fromMap(taskMap)),
      ),
    );
  }
}