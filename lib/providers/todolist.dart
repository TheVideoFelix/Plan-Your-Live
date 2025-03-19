import 'package:flutter/material.dart';
import 'package:plan_your_live/models/todolist/todo_model.dart';
import 'package:plan_your_live/models/todolist/todolist_model.dart';
import 'package:plan_your_live/services/todolists_service.dart';

class TodolistNotifier extends ChangeNotifier {
  final TodolistsService _todolistsService = TodolistsService();

  // General cache
  List<TodolistModel> _todolists = [];
  Map<String, TodoModel> _todos = {};
  // Load todolist
  TodolistModel? _todolist;

  // Pending state
  bool _isLoading = false;

  // Getters
  List<TodolistModel> get todolists => [..._todolists];

  TodolistModel? get todolist => _todolist;

  bool get isLoading => _isLoading;

  void clear() {
    _todolists = [];
    _todos = {};
    _todolist = null;
    _isLoading = false;
  }

  // Fetches and sets the todolist with todos
  Future<void> fetchAndSetTodolistWithTodos() async {
    _isLoading = true;
    List<TodolistModel>? result = await _todolistsService.fetchTodolists();
    _todolists = result ?? [];
    if (_todolists.isEmpty && _todos.isEmpty) {
      List<TodolistModel> todolists = await _todolistsService
          .fetchTodolists() ?? [];
      for (TodolistModel todolist in todolists) {
        List<TodoModel> todos = await _todolistsService.fetchTodos(
            todolist.id) ?? [];
        for (TodoModel todo in todos) {
          _todos[todo.id] = todo;
          todolist.todos.add(todo);
        }
        _todolists.add(todolist);
      }
    }
    _isLoading = false;
    notifyListeners();
  }

  /*
      Todolists
   */

  // Inserts a todolist at a specific index
  Future<void> insertTodolist(TodolistModel todolist, int index) async {
    await _todolistsService.insertTodolist(todolist);
    if (index >= _todolists.length) index = _todolists.length;
    _todolists.insert(index, todolist);
    notifyListeners();
  }

  // Adds a new todolist
  Future<void> addTodolist(TodolistModel todolist) async {
    await _todolistsService.insertTodolist(todolist);
    _todolists.add(todolist);
    notifyListeners();
  }

  //
  Future<void> updateTodolist(TodolistModel todolist) async {
    await _todolistsService.updateTodolist(todolist);
    int? index = _todolists.indexWhere((t) => t.id == todolist.id);
    if (index != -1) {
      _todolists[index] = todolist;
      notifyListeners();
    }
  }

  Future<void> removeTodolist(String todolistId) async {
    _recentlyRemovedTodolist = _todolists.firstWhere((t) => t.id == todolistId);
    _recentlyRemovedTodolistIndex = _todolists.indexWhere((t) => t.id == todolistId);
    await _todolistsService.deleteTodolist(todolistId);
    _todolists.removeWhere((t) => t.id == todolistId);
  //
  Future<RecentlyRemoved<TodolistModel>> removeTodolist(
      TodolistModel todolist) async {
    RecentlyRemoved<TodolistModel> removed = RecentlyRemoved(
        todolist,
        _todolists.indexWhere((t) => t.id == todolist.id));

    // removes the todolist
    await _todolistsService.deleteTodolist(todolist.id);
    _todolists.removeAt(removed.index);

    // removes the todos for the cache and db
    for (TodoModel todo in todolist.todos) {
      final String todoId = todo.id;
      await _todolistsService.deleteTodo(todoId);
      _todos.remove(todoId);
    }

    notifyListeners();
    return removed;
  }

  //
  Future<void> undoRemoveTodolist(
      RecentlyRemoved<TodolistModel> removed) async {
    await insertTodolist(removed.item, removed.index);

    // insert the todos back
    for (TodoModel todo in removed.item.todos) {
      final String todoId = todo.id;
      await _todolistsService.insertTodo(todo, removed.item.id);
      _todos[todoId] = todo;
    }

  
    notifyListeners();
  }

  Future<void> undoRemoveTodolist() async {
    if (_recentlyRemovedTodolist != null) {
      await insertTodolist(_recentlyRemovedTodolist!, _recentlyRemovedTodolistIndex);
      _recentlyRemovedTodolist = null;
      notifyListeners();
    }
  }

  /*
      Todolist
   */

  //
  Future<void> fetchAndSetTodolist(TodolistModel todolist) async {
    _isLoading = true;
    if (todolist.todos.isEmpty) {
      todolist.todos = getTodos(todolist);
    }
    _todolist = todolist;
    _isLoading = false;
    notifyListeners();
  }


  /*
      Todos
   */

  //
  List<TodoModel> getTodos(TodolistModel todolist) {
    return _todos.values
        .where((todo) => todo.todolistId == todolist.id)
        .toList();
  }

  //
  Future<void> insertTodo(TodoModel todo, int index) async {
    await _todolistsService.insertTodo(todo, todo.todolistId);
    TodolistModel parent = _todolists.firstWhere((t) =>
    t.id == todo.todolistId);
    if (index >= parent.todos.length || index < 0) index = parent.todos.length;
    parent.todos.insert(index, todo);
    _todos[todo.id] = todo;
    notifyListeners();
  }

  //
  Future<void> addTodo(TodoModel todo) async {
    await insertTodo(todo, -1);
    notifyListeners();
  }

  //
  Future<void> updateTodo(TodoModel todo) async {
    await _todolistsService.updateTodo(todo);

    final TodolistModel parent = _todolists.firstWhere((t) =>
    t.id == todo.todolistId);
    int index = parent.todos.indexWhere((t) => t.id == todo.id);
    if (index >= parent.todos.length || index < 0) index = parent.todos.length;

    parent.todos.insert(index, todo);
    _todos.update(todo.id, (e) => todo);

    notifyListeners();
  }

  //
  Future<void> checkTodo(TodoModel todo) async {
    todo.isChecked = !todo.isChecked;
    await _todolistsService.updateTodo(todo);
    notifyListeners();
  }

  //
  Future<RecentlyRemoved<TodoModel>> removeTodo(TodoModel todo) async {
    final TodolistModel parent = _todolists.firstWhere((t) =>
    t.id == todo.todolistId);
    final RecentlyRemoved<TodoModel> removed = RecentlyRemoved(
        _todos[todo.id]!, parent.todos.indexWhere((t) => t.id == todo.id));

    parent.todos.removeWhere((t) => t.id == todo.id);
    await _todolistsService.deleteTodo(todo.id);

    _todos.remove(todo.id);

    notifyListeners();
    return removed;
  }

  //
  Future<void> undoRemoveTodo(RecentlyRemoved<TodoModel> removed) async {
    await insertTodo(removed.item, removed.index);
    notifyListeners();
  }
}