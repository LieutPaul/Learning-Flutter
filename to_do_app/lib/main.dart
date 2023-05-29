import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: "To Do App",
      home: TaskList(tasks: [
        Task("Task1", false),
        Task("Task2", false),
        Task("Task3", false),
        Task("Task4", false)
      ])));
}

typedef TaskFunction = Function(Task task);

class Task {
  final String task;
  bool completed;
  Task(this.task, this.completed);

  bool getCompleted() {
    return completed;
  }

  void setCompleted(bool b) {
    completed = b;
  }
}

class TaskTile extends StatelessWidget {
  final int index;
  final Task task;
  final TaskFunction changeTaskStatus;
  const TaskTile(
      {super.key,
      required this.task,
      required this.index,
      required this.changeTaskStatus});

  Color? _getColour(BuildContext context) {
    if (task.completed == true) {
      return const Color.fromARGB(255, 47, 150, 50);
    } else {
      return const Color.fromARGB(255, 227, 71, 60);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
          backgroundColor: _getColour(context), child: Text('$index')),
      title: Text(task.task),
      onTap: () => changeTaskStatus(task),
    );
  }
}

class TaskList extends StatefulWidget {
  final List<Task> tasks;
  const TaskList({super.key, required this.tasks});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  int _index = 0;

  void _changeTaskStatus(Task task) {
    setState(() {
      _index = 0;
      task.setCompleted(!(task.getCompleted()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("To do List")),
        body: ListView(
          children: widget.tasks.map((task) {
            _index++;
            return TaskTile(
                task: task, index: _index, changeTaskStatus: _changeTaskStatus);
          }).toList(),
        ));
  }
}
