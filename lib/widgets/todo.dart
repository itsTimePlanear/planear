import 'package:riverpod/riverpod.dart';

class Todo {
  final String _title;
  Todo(this._title);

  String get title => _title;
}

class TodoModel {
  List<Todo> todos = <Todo>[];
  int get count => todos.length;
  TodoModel({required this.todos});
}

//final todoModelStateProvider = StateProvider((ref) => TodoModel(todos: []));

final todoModelStateProvider = StateProvider((ref) => TodoModel(todos: [
      Todo("강아지 산책하기"),
      Todo("공부하기"),
      Todo("장보기"),
      Todo("장보기"),
      Todo("장보기"),
      Todo("장보기"),
      Todo("장보기"),
    ]));