import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              provider.logout();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: provider.state == TaskState.loading
          ? const Center(child: CircularProgressIndicator())
          : provider.state == TaskState.error
              ? Center(child: Text(provider.errorMessage ?? 'Error'))
              : ListView.builder(
                  itemCount: provider.tasks.length,
                  itemBuilder: (context, index) {
                    final task = provider.tasks[index];
                    return ListTile(
                      title: Text(task.title),
                      trailing: Icon(
                        task.completed ? Icons.check_circle : Icons.circle_outlined,
                        color: task.completed ? Colors.green : Colors.grey,
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = Task(id: DateTime.now().millisecondsSinceEpoch, title: 'Task Baru', completed: false);
          await provider.addTask(newTask);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
