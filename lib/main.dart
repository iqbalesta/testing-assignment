import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/task.dart';
import 'services/task_api_service.dart';
import 'services/task_sqlite_service.dart';
import 'providers/task_provider.dart';
import 'screens/login_screen.dart';
import 'screens/task_list_screen.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy in-memory SQLite db, replace with real db in production
    final fakeDb = null;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TaskProvider(
            apiService: TaskApiService(baseUrl: 'https://mock.api/test'),
            sqliteService: fakeDb == null ? DummySqliteService() : TaskSqliteService(fakeDb),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'PPB Testing Assignment',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginScreen(),
        routes: {
          '/tasks': (_) => const TaskListScreen(),
        },
      ),
    );
  }
}

// DummySqliteService hanya untuk development/testing agar aplikasi bisa jalan tanpa db
class DummyDatabase extends Mock implements Database {}
class DummySqliteService implements TaskSqliteService {
  final Database _db = DummyDatabase();
  @override
  Database get db => _db;
  @override
  Future<void> insertTask(Task task) async {}
  @override
  Future<List<Task>> getTasks() async => [];
}
