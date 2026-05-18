import 'package:june/Models/task.dart';
import 'package:june/main.dart';

class TaskService {
  static Future<List<Task>> fetchForDate(DateTime date) async {
    final dayStart = DateTime(date.year, date.month, date.day);
    final dayEnd = dayStart.add(const Duration(days: 1));

    final response = await supabase
        .from('Tasks')
        .select()
        .eq('user_id', supabase.auth.currentUser!.id)
        .gte('starts_at', dayStart.toIso8601String())
        .lt('starts_at', dayEnd.toIso8601String())
        .order('starts_at');

    return (response as List)
        .map((json) => Task.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  static Future<String> insert({
    required String title,
    required DateTime startsAt,
    required DateTime endsAt,
  }) async {
    final response = await supabase.from('Tasks').insert({
      'title': title,
      'starts_at': startsAt.toIso8601String(),
      'ends_at': endsAt.toIso8601String(),
      'status': 'pending',
      'user_id': supabase.auth.currentUser!.id,
    }).select('id').single();
    return response['id'] as String;
  }

  static Future<void> updateStatus(String id, String status) async {
    await supabase.from('Tasks').update({'status': status}).eq('id', id);
  }

  static Future<void> update({
    required String id,
    required String title,
    required DateTime startsAt,
    required DateTime endsAt,
  }) async {
    await supabase.from('Tasks').update({
      'title': title,
      'starts_at': startsAt.toIso8601String(),
      'ends_at': endsAt.toIso8601String(),
    }).eq('id', id);
  }

  static Future<void> delete(String id) async {
    await supabase.from('Tasks').delete().eq('id', id);
  }
}
