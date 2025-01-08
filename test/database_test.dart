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

    // insert
    int id = await todolistsService.insertTodolist(todolist);
    expect(id, isNotNull);

    // fetch
    TodolistModel? result = await todolistsService.fetchTodolist(todolist.id);
    expect(result != null, true);
    expect(result?.title, todolist.title);

    //update
    result?.title = "New Todolist title";
    result?.description = "New description";

    int update = await todolistsService.updateTodolist(result!);
    expect(update, isNotNull);

    TodolistModel? resultUpdated = await todolistsService.fetchTodolist(todolist.id);
    expect(resultUpdated != null, true);
    expect(resultUpdated?.title, result.title);
    expect(resultUpdated?.description, result.description);

    // delete
    int deleteId = await todolistsService.deleteTodolist(todolist.id);
    expect(deleteId, isNotNull);

    TodolistModel? deletedResult = await todolistsService.fetchTodolist(todolist.id);
    expect(deletedResult == null, true);
  });

  test('Insert and retrieve a todos', () async  {
    TodolistModel todolist = TodolistModel(
        title: "Shopping list ");
    todolist.todos.add(TodoModel(title: "Eggs", isChecked: true));
    todolist.todos.add(TodoModel(title: "Apples", description: "if the not have bio then take no apples.", isChecked: false));
    todolist.todos.add(TodoModel(title: "Watter", isChecked: false));

    // insert
    int id = await todolistsService.insertTodolist(todolist);
    expect(id, isNotNull);

    List<int> ids = await todolistsService.insertTodos(todolist);
    expect(ids, isNotNull);

    // fetch
    TodolistModel? result = await todolistsService.fetchTodolist(todolist.id);
    expect(result != null, true);

    List<TodoModel>? todos = await todolistsService.fetchTodos(todolist.id);
    expect(todos != null, true);

    result?.todos = todos!;
    expect(result?.todos.isNotEmpty, true);
    expect(result?.todos.first.title, todolist.todos.first.title);

    // update
    todos?.first.title = "New Shopping list";
    todos?.first.description = "My fancie description";

    int update = await todolistsService.updateTodo(todos!.first, result!.id);
    expect(update, isNotNull);

    List<TodoModel>? updatedTodos = await todolistsService.fetchTodos(todolist.id);
    expect(updatedTodos != null, true);

    expect(updatedTodos?.isNotEmpty, true);
    expect(updatedTodos?.first.title, result?.todos.first.title);

    // delete
    int deleteTodo = await todolistsService.deleteTodo(todolist.todos.first.id);
    expect(deleteTodo, isNotNull);

    List<TodoModel>? deleteTodos = await todolistsService.fetchTodos(todolist.id);
    expect(deleteTodos != null, true);

    result?.todos = deleteTodos!;
    expect(result?.todos.isNotEmpty, true);
    expect(result?.todos.first.id != todolist.todos.first.id, true);
  });


}