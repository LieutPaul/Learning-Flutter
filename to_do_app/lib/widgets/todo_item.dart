import 'package:flutter/material.dart';
import 'package:to_do_app/constants/constants.dart';
import 'package:to_do_app/model/todo.dart';

typedef ChangeTaskStatus = Function(ToDo todo);
typedef DeleteTask = Function(ToDo todo);

class ToDoItem extends StatelessWidget {
  final ToDo toDo;
  final ChangeTaskStatus f;
  final DeleteTask d;
  const ToDoItem(
      {super.key, required this.toDo, required this.f, required this.d});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: ListTile(
          onTap: () => {f(toDo)},
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          tileColor: Colors.white,
          leading: Icon(
            toDo.isDone == true
                ? Icons.check_box
                : Icons.check_box_outline_blank,
            color: tdBlue,
          ),
          title: Text(
            toDo.todoText,
            style: TextStyle(
                fontSize: 16,
                color: tdBlack,
                decoration:
                    toDo.isDone == true ? TextDecoration.lineThrough : null),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          trailing: Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.symmetric(vertical: 12),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  color: tdRed, borderRadius: BorderRadius.circular(5)),
              child: IconButton(
                color: Colors.white,
                icon: const Icon(Icons.delete),
                iconSize:
                    20, // You need to set the size of your icon with size attribute for it to be centered
                onPressed: () => {d(toDo)},
              )),
        ));
  }
}
