import 'package:flutter/material.dart';

class Task {
  String taskName;
  String description;
  DateTime date; 
  TimeOfDay startTime;
  TimeOfDay endTime;
  bool? isCompleted;

  Task({
    required this.taskName,
    this.description = "",
    required this.date,
    required this.startTime,
    required this.endTime,
    this.isCompleted = false,
  });

  Task copyWith({
    String? taskName,
    String? description,
    DateTime? date,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    bool? isCompleted,
  }) {
    return Task(
      taskName: taskName ?? this.taskName,
      description: description ?? this.description,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'taskName': taskName,
      'description': description,
      'date': date.toIso8601String(), 
      'startTime': '${startTime.hour}:${startTime.minute}',
      'endTime': '${endTime.hour}:${endTime.minute}',
      'isCompleted': isCompleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    TimeOfDay parseTime(String timeString) {
      final parts = timeString.split(':');
      return TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
    }

    return Task(
      taskName: map['taskName'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] != null ? DateTime.parse(map['date']) : DateTime.now(), 
      startTime: parseTime(map['startTime'] ?? '00:00'),
      endTime: parseTime(map['endTime'] ?? '00:00'),
      isCompleted: map['isCompleted'] ?? false,
    );
  }
}