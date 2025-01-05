import 'package:plan_your_live/models/todolist/todolist_model.dart';
import 'package:plan_your_live/shared/db/database_service.dart';

class TodolistsService {
  final DatabaseService _databaseService = DatabaseService();

  Future<int> insertTodolist(TodolistModel todolist) async {
    final db = await _databaseService.database;
    return await db.insert('todolists', todolist.toMap());
  }
}