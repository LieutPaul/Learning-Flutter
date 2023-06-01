import 'package:flutter/material.dart';
import 'package:to_do_app/constants/constants.dart';
import 'package:to_do_app/model/todo.dart';
import 'package:to_do_app/widgets/todo_item.dart';

class Home extends StatefulWidget {
  final toDoList = ToDo.firstToDoList();
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  void _changeTaskStatus(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteTask(ToDo todo) {
    setState(() {
      widget.toDoList.removeWhere((element) => element == todo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tdBGColor,
        appBar: _buildAppBar(),
        body: Stack(children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(children: [
                _searchBox(),
                Expanded(
                    child: ListView(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 30, bottom: 30),
                        child: const Text(
                          "All ToDos",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w800),
                        )),
                    for (ToDo toDo in widget.toDoList)
                      ToDoItem(toDo: toDo, f: _changeTaskStatus, d: _deleteTask)
                  ],
                ))
              ])),
          Align(alignment: Alignment.bottomCenter, child: _addNewItem())
        ]));
  }

  Row _addNewItem() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 10.0,
                      spreadRadius: 0.0)
                ]),
            child: TextField(
              controller: myController,
              decoration: const InputDecoration(
                  hintText: "Add a new todo item", border: InputBorder.none),
            ),
          ),
        ),
        Container(
            margin: const EdgeInsets.only(bottom: 20, right: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: tdBlue,
                  elevation: 10,
                  minimumSize: const Size(55, 55)),
              onPressed: () => {
                if (myController.text != "")
                  {
                    setState(() {
                      widget.toDoList.add(
                          ToDo(todoText: myController.text, isDone: false));
                      myController.clear();
                      FocusManager.instance.primaryFocus?.unfocus();
                    })
                  }
              },
              child: const Text(
                '+',
                style: TextStyle(fontSize: 40),
              ),
            ))
      ],
    );
  }

  Container _searchBox() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: const TextField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              prefixIcon: Icon(
                Icons.search,
                color: tdBlack,
                size: 20,
              ),
              // https://api.flutter.dev/flutter/material/InputDecoration/prefixIconConstraints.html
              prefixIconConstraints:
                  BoxConstraints(maxHeight: 20, minHeight: 20),
              border: InputBorder.none,
              hintText: "Search"),
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
        backgroundColor: tdBGColor,
        elevation: 0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.menu,
              color: tdBlack,
              size: 30,
            ),
            Icon(
              Icons.person,
              color: tdBlack,
              size: 30,
            )
          ],
        ));
  }
}
