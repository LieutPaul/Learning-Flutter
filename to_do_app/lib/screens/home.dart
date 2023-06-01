import 'package:flutter/material.dart';
import 'package:to_do_app/constants/constants.dart';
import 'package:to_do_app/widgets/todo_item.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tdBGColor,
        appBar: _buildAppBar(),
        body: Container(
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
                  ToDoItem()
                ],
              ))
            ])));
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
