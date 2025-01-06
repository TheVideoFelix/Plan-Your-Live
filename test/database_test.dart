import 'package:flutter_test/flutter_test.dart';
import 'package:plan_your_live/models/todolist/todo_model.dart';
import 'package:plan_your_live/models/todolist/todolist_model.dart';
import 'package:plan_your_live/services/todolists_service.dart';
import 'package:plan_your_live/shared/db/database_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  DatabaseService databaseService = DatabaseService();
  TodolistsService todolistsService = TodolistsService();


  setUp(() async {
    await databaseService.database;
  });

  tearDown(() async {
    await databaseService.database.then((db) => db.close());
  });


  test('Insert and retrieve a todolist', () async  {
    TodolistModel todolist = TodolistModel(
        title: "Todolist test");

    int id = await todolistsService.insertTodolist(todolist);
    expect(id, isNotNull);

    final db = await databaseService.database;
    List<Map<String, dynamic>> result = await db.query('todolists', where: 'id = ?', whereArgs: [
      todolist.id
    ]);

    expect(result.isNotEmpty, true);
    expect(result.first['title'], todolist.title);
  });

  test('Insert and retrieve a todos', () async  {
    TodolistModel todolist = TodolistModel(
        title: "Shopping list ");
    todolist.todos.add(TodoModel(title: "Eggs", isChecked: true));
    todolist.todos.add(TodoModel(title: "Apples", description: "if the not have bio then take no apples.", isChecked: false));
    todolist.todos.add(TodoModel(title: "Watter", isChecked: false));

    int id = await todolistsService.insertTodolist(todolist);
    expect(id, isNotNull);

    List<int> ids = await todolistsService.insertTodos(todolist);
    expect(ids, isNotNull);

    final db = await databaseService.database;
    List<Map<String, dynamic>> result = await db.query('todos', where: 'todolistId = ?', whereArgs: [
      todolist.id
    ]);

    expect(result.isNotEmpty, true);
  });
}