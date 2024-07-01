import 'package:riverpod/riverpod.dart';

class Todo {
  final String _title;
  final bool _isCompleted;
  Todo(this._title, this._isCompleted);

  String get title => _title;
  bool get isCompleted => _isCompleted;
}

class TodoModel {
  List<Todo> todos = <Todo>[];
  int get count => todos.length;
  TodoModel({required this.todos});
}

//final todoModelStateProvider = StateProvider((ref) => TodoModel(todos: []));

final todoModelStateProvider = StateProvider((ref) => TodoModel(todos: [
      Todo("강아지 산책하기", false),
      Todo("공부하기", true),
      Todo("장보기", true),
      Todo("장보기", false),
      Todo("장보기", false),
      Todo("장보기", true),
      Todo("장보기", false),
    ]));