import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_api_service.dart';
import '../services/task_sqlite_service.dart';

enum TaskState { idle, loading, error }

enum AuthState { loggedOut, loggedIn, loading, error }

class TaskProvider extends ChangeNotifier {
  final TaskApiService apiService;
  final TaskSqliteService sqliteService;

  List<Task> _tasks = [];
  TaskState _state = TaskState.idle;
  AuthState _authState = AuthState.loggedOut;
  String? _errorMessage;

  TaskProvider({required this.apiService, required this.sqliteService});

  List<Task> get tasks => _tasks;
  TaskState get state => _state;
  AuthState get authState => _authState;
  String? get errorMessage => _errorMessage;

  Future<void> login(String username, String password) async {
    _authState = AuthState.loading;
    notifyListeners();
    try {
      // Simulasi login
      await Future.delayed(const Duration(milliseconds: 500));
      if (username == 'user' && password == 'pass') {
        _authState = AuthState.loggedIn;
      } else {
        _authState = AuthState.error;
        _errorMessage = 'Invalid credentials';
      }
    } catch (e) {
      _authState = AuthState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> logout() async {
    _authState = AuthState.loggedOut;
    notifyListeners();
  }

  Future<void> fetchTasks({bool fromApi = true}) async {
    _state = TaskState.loading;
    notifyListeners();
    try {
      if (fromApi) {
        _tasks = await apiService.fetchTasks();
        // Simpan ke SQLite
        for (final t in _tasks) {
          await sqliteService.insertTask(t);
        }
      } else {
        _tasks = await sqliteService.getTasks();
      }
      _state = TaskState.idle;
    } catch (e) {
      _state = TaskState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    _state = TaskState.loading;
    notifyListeners();
    try {
      final newTask = await apiService.createTask(task);
      await sqliteService.insertTask(newTask);
      _tasks.add(newTask);
      _state = TaskState.idle;
    } catch (e) {
      _state = TaskState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }
}
