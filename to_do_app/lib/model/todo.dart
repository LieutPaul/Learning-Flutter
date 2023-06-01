class ToDo {
  String? todoText;
  bool isDone;

  ToDo({required this.todoText, this.isDone = false});

  static List<ToDo> firstToDoList() {
    return [
      ToDo(todoText: "Go Jogging", isDone: true),
      ToDo(todoText: "Do LeetCode"),
      ToDo(todoText: "Learn Flutter"),
      ToDo(todoText: "Watch The Flash Season 9"),
    ];
  }
}
