import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task.dart';

class TaskApiService {
  final String baseUrl;
  final http.Client client;

  TaskApiService({required this.baseUrl, http.Client? client}) : client = client ?? http.Client();

  Future<List<Task>> fetchTasks() async {
    final response = await client.get(Uri.parse('$baseUrl/tasks'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Task.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<Task> createTask(Task task) async {
    final response = await client.post(
      Uri.parse('$baseUrl/tasks'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toJson()),
    );
    if (response.statusCode == 201) {
      return Task.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create task');
    }
  }

  // Tambahkan update dan delete jika diperlukan
}
