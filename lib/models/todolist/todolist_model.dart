import 'package:plan_your_live/models/todolist/todo_model.dart';
import 'package:plan_your_live/shared/utils/utils.dart';
import 'package:uuid/uuid.dart';

class TodolistModel {
  final String id;
  final String title;
  final String? description;
  final DateTime? createdAt;
  final List<TodoModel> todos;

  TodolistModel({
    String? id,
    required this.title,
    this.description,
    this.createdAt,
    required this.todos,
  }) : id = id ?? Utils.getUuid();

  Map<String, Object?> toMap() {
    Map<String, Object?> map = <String, Object?>{};
    map['id'] = id;
    map['title'] = title;
    if (description != null) map['description'] = description;
    if (createdAt != null) map['createdAt'] = createdAt;

    return map;
  }

}
