import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: "To Do App", home: TaskList()));
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

// ignore: must_be_immutable
class TaskList extends StatefulWidget {
  List<Task> tasks = [];
  TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  FloatingActionButton addANewTask() {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Enter New Task'),
          content: TextFormField(
            controller: taskController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                taskController.clear();
                Navigator.pop(context, 'Cancel');
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _addTask(taskController.text);
                taskController.clear();
                Navigator.pop(context, 'OK');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }

  void _addTask(String task) {
    setState(() {
      setState(() {
        widget.tasks.add(Task(task, false));
      });
    });
  }

  void _changeTaskStatus(Task task) {
    setState(() {
      task.setCompleted(!(task.getCompleted()));
    });
  }

  final TextEditingController taskController = TextEditingController();

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("To do List")),
        body: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ListView(
              children: widget.tasks.map((task) {
                return TaskTile(
                    task: task,
                    index: widget.tasks.indexOf(task) + 1,
                    changeTaskStatus: _changeTaskStatus);
              }).toList(),
            )),
        floatingActionButton: addANewTask());
  }
}
