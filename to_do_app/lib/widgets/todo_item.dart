import 'package:flutter/material.dart';
import 'package:to_do_app/constants/constants.dart';
import 'package:to_do_app/model/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo toDo;
  const ToDoItem({super.key, required this.toDo});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: ListTile(
          onTap: () => {},
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          tileColor: Colors.white,
          leading: const Icon(
            Icons.check_box,
            color: tdBlue,
          ),
          title: Text(
            toDo.todoText!,
            style: const TextStyle(
                fontSize: 16,
                color: tdBlack,
                decoration: TextDecoration.lineThrough),
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
                onPressed: () => {},
              )),
        ));
  }
}
