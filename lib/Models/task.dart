class Task {
  final String id;
  final String title;
  final DateTime startsAt;
  final DateTime endsAt;
  final String status;
  final String userId;

  const Task({
    required this.id,
    required this.title,
    required this.startsAt,
    required this.endsAt,
    required this.status,
    required this.userId,
  });

  bool get isCompleted => status == 'completed';

  String get timeRange {
    String fmt(DateTime dt) {
      final hour = dt.hour == 0
          ? 12
          : dt.hour > 12
              ? dt.hour - 12
              : dt.hour;
      final minute = dt.minute.toString().padLeft(2, '0');
      final period = dt.hour < 12 ? 'AM' : 'PM';
      return '$hour:$minute $period';
    }

    return '${fmt(startsAt)} – ${fmt(endsAt)}';
  }

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'] as String,
        title: json['title'] as String,
        startsAt: DateTime.parse(json['starts_at'] as String),
        endsAt: DateTime.parse(json['ends_at'] as String),
        status: (json['status'] as String?) ?? 'pending',
        userId: json['user_id'] as String,
      );

  Task copyWith({String? title, DateTime? startsAt, DateTime? endsAt, String? status}) => Task(
        id: id,
        title: title ?? this.title,
        startsAt: startsAt ?? this.startsAt,
        endsAt: endsAt ?? this.endsAt,
        status: status ?? this.status,
        userId: userId,
      );
}
