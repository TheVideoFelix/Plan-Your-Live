import 'package:plan_your_live/models/todolist/todo_model.dart';
import 'package:plan_your_live/models/todolist/todolist_model.dart';
import 'package:plan_your_live/shared/db/database_service.dart';

class TodolistsService {
  final DatabaseService _databaseService = DatabaseService();

  // Todolist

  Future<int> insertTodolist(TodolistModel todolist) async {
    final db = await _databaseService.database;
    return await db.insert('todolists', todolist.toMap());
  }

  Future<List<Map<String, dynamic>>> fetchTodolistData(String todolistId) async {
    final db = await _databaseService.database;
    return await db.query('todolists', where: 'id = ?', whereArgs: [
      todolistId
    ]);
  }

  Future<TodolistModel?> fetchTodolist(String todolistId) async {
    List<Map<String, dynamic>> result = await fetchTodolistData(todolistId);
    if (result.isEmpty) return null;
    return TodolistModel.fromMap(result.first);
  }

  Future<int> deleteTodolist(String todolistId) async {
    final db = await _databaseService.database;
    return await db.delete('todolists', where: 'id = ?', whereArgs: [
      todolistId
    ]);
  }

  // Todo

  Future<List<int>> insertTodos(TodolistModel todolist) async {
    List<int> ids = [];
    for (var todo in todolist.todos) {
      int id = await insertTodo(todo, todolist.id);
      ids.add(id);
    }
    return ids;
  }

  Future<int> insertTodo(TodoModel todo, String todolistId) async {
    final db = await _databaseService.database;
    return await db.insert('todos', todo.toMap(todolistId));
  }

  Future<List<Map<String, dynamic>>> fetchTodosData(String todolistId) async {
    final db = await _databaseService.database;
    return await db.query('todos', where: 'todolistId = ?', whereArgs: [
      todolistId
    ]);
  }

  Future<List<TodoModel>?> fetchTodos(String todolistId) async {
    List<Map<String, dynamic>> results = await fetchTodosData(todolistId);
    if (results.isEmpty) return null;
    return results.map((result) => TodoModel.fromMap(result)).toList();
  }

  Future<int> deleteTodo(String todoId) async {
    final db = await _databaseService.database;
    return await db.delete('todos', where: 'id = ?', whereArgs: [
      todoId
    ]);
  }
}