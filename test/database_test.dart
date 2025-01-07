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

  tearDownAll(() async {
    await databaseService.database.then((db) => db.close());
  });


  test('Insert and retrieve a todolist', () async  {
    TodolistModel todolist = TodolistModel(
        title: "Todolist test");

    int id = await todolistsService.insertTodolist(todolist);
    expect(id, isNotNull);

    TodolistModel? result = await todolistsService.fetchTodolist(todolist.id);
    expect(result != null, true);
    expect(result?.title, todolist.title);
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

    TodolistModel? result = await todolistsService.fetchTodolist(todolist.id);
    expect(result != null, true);

    List<TodoModel>? todos = await todolistsService.fetchTodos(todolist.id);
    expect(todos != null, true);

    result?.todos = todos!;
    expect(result?.todos.isNotEmpty, true);
  });
}