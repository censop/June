class Subtask {
  final String id;
  final String title;
  final bool done;
  final String taskId;

  const Subtask({
    required this.id,
    required this.title,
    required this.done,
    required this.taskId,
  });

  factory Subtask.fromJson(Map<String, dynamic> json) => Subtask(
        id: json['id'] as String,
        title: json['title'] as String,
        done: (json['done'] as bool?) ?? false,
        taskId: json['task_id'] as String,
      );

  Subtask copyWith({String? title, bool? done}) => Subtask(
        id: id,
        title: title ?? this.title,
        done: done ?? this.done,
        taskId: taskId,
      );
}
