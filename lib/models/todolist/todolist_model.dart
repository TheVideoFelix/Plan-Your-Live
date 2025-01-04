import 'package:plan_your_live/models/todolist/todo_model.dart';

class TodolistModel {
  final String id;
  final String title;
  final String? description;
  final String createdAt;
  final List<TodoModel> todos;

  const TodolistModel({
    required this.id,
    required this.title,
    this.description,
    required this.createdAt,
    required this.todos,
  });
}
