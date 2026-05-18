import 'package:june/Models/subtask.dart';
import 'package:june/main.dart';

class SubtaskService {
  static Future<List<Subtask>> fetchForTask(String taskId) async {
    final response = await supabase
        .from('Subtasks')
        .select()
        .eq('task_id', taskId)
        .order('created_at');

    return (response as List)
        .map((json) => Subtask.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  static Future<void> insert({
    required String taskId,
    required String title,
    bool done = false,
  }) async {
    await supabase.from('Subtasks').insert({
      'task_id': taskId,
      'title': title,
      'done': done,
    });
  }

  static Future<void> deleteAllForTask(String taskId) async {
    await supabase.from('Subtasks').delete().eq('task_id', taskId);
  }

  static Future<void> updateDone(String id, bool done) async {
    await supabase.from('Subtasks').update({'done': done}).eq('id', id);
  }

  static Future<void> updateTitle(String id, String title) async {
    await supabase.from('Subtasks').update({'title': title}).eq('id', id);
  }

  static Future<void> delete(String id) async {
    await supabase.from('Subtasks').delete().eq('id', id);
  }
}
