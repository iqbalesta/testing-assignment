import 'package:sqflite/sqflite.dart';
import '../models/task.dart';

class TaskSqliteService {
  final Database db;
  TaskSqliteService(this.db);

  Future<void> insertTask(Task task) async {
    await db.insert('tasks', task.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Task>> getTasks() async {
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) => Task.fromJson(maps[i]));
  }

  // Tambahkan update dan delete jika diperlukan
}
