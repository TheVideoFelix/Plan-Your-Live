import 'package:plan_your_live/models/todolist/todo_model.dart';
import 'package:plan_your_live/shared/utils/utils.dart';

class TodolistModel {
  final String id;
  final String title;
  final String? description;
  final DateTime? createdAt;
  List<TodoModel> todos;

  TodolistModel({
    String? id,
    required this.title,
    this.description,
    this.createdAt,
    List<TodoModel>? todos,
  })  : id = id ?? Utils.getUuid(),
        todos = todos ?? <TodoModel>[];

  factory TodolistModel.fromMap(Map<String, dynamic> todolist) => TodolistModel(
    id: todolist['id'],
    title: todolist['title'],
    description: todolist['description'] ?? '',
    createdAt: DateTime.tryParse(todolist['createdAt'] as String),
  );

  Map<String, dynamic> toMap() {
    Map<String, Object?> map = <String, Object?>{};
    map['id'] = id;
    map['title'] = title;
    if (description != null) map['description'] = description;
    if (createdAt != null) map['createdAt'] = createdAt;

    return map;
  }

}
