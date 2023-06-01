class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({required this.id, required this.todoText, this.isDone = false});

  static List<ToDo> firstToDoList() {
    return [
      ToDo(id: '01', todoText: "Go Jogging", isDone: true),
      ToDo(id: '02', todoText: "Do LeetCode"),
      ToDo(id: '03', todoText: "Learn Flutter"),
      ToDo(id: '04', todoText: "Watch The Flash Season 9"),
    ];
  }
}
