import 'package:flutter/material.dart';
import 'package:plan_your_live/models/todolist/recently_removed.dart';
import 'package:plan_your_live/models/todolist/todo_model.dart';
import 'package:plan_your_live/models/todolist/todolist_model.dart';
import 'package:plan_your_live/services/todolists_service.dart';

class TodolistNotifier extends ChangeNotifier {
  final TodolistsService _todolistsService = TodolistsService();

  // General cache
  List<TodolistModel> _todolists = [];
  Map<String, TodoModel> _todos = {};

  // Favorites
  List<TodolistModel> _favoriteTodolists = [];
  List<TodoModel> _todosDoDate = [];

  // Load todolist
  TodolistModel? _todolist;

  // Pending state
  bool _isLoading = false;

  // Getters
  List<TodolistModel> get todolists => [..._todolists];

  TodolistModel? get todolist => _todolist;

  bool get isLoading => _isLoading;

  List<TodolistModel> get favoriteTodolists => [..._favoriteTodolists];

  List<TodoModel> get todosDoDate => [..._todosDoDate];

  void clear() {
    _todolists = [];
    _todos = {};
    _favoriteTodolists = [];
    _todosDoDate = [];
    _todolist = null;
    _isLoading = false;
  }

  // Fetches and sets the todolist with todos
  Future<void> fetchAndSetTodolistWithTodos() async {
    _isLoading = true;
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
        if (todolist.isFavorite) _favoriteTodolists.add(todolist);
      }
    }
    fetchAndSetTodoByDoDate();
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
    if (todolist.isFavorite) _favoriteTodolists.add(todolist);
    notifyListeners();
  }

  // Adds a new todolist
  Future<void> addTodolist(TodolistModel todolist) async {
    await _todolistsService.insertTodolist(todolist);
    _todolists.add(todolist);
    if (todolist.isFavorite) _favoriteTodolists.add(todolist);
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

  //
  Future<RecentlyRemoved<TodolistModel>> removeTodolist(
      TodolistModel todolist) async {
    RecentlyRemoved<TodolistModel> removed = RecentlyRemoved(
        todolist,
        _todolists.indexWhere((t) => t.id == todolist.id));

    // removes the todolist
    await _todolistsService.deleteTodolist(todolist.id);
    _todolists.removeAt(removed.index);
    _favoriteTodolists.remove(todolist);

    // removes the todos for the cache and db
    for (TodoModel todo in todolist.todos) {
      final String todoId = todo.id;
      await _todolistsService.deleteTodo(todoId);
      _todos.remove(todoId);
      _todosDoDate.remove(todo);
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
      if (todo.doDate != null && todo.doDate!.isAfter(DateTime.now())) {
        _todosDoDate.add(todo);
      }
    }
    _todosDoDate.sort((a,b) => a.doDate!.compareTo(b.doDate!));

    notifyListeners();
  }
  
  // make a todolist favorite
  Future<void> favoriteTodolist(TodolistModel todolist) async {
    todolist.isFavorite = !todolist.isFavorite;
    if (todolist.isFavorite) {
      _favoriteTodolists.add(todolist);
    } else {
      _favoriteTodolists.remove(todolist);
    }

    await _todolistsService.updateTodolist(todolist);
    notifyListeners();
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
  void fetchAndSetTodoByDoDate() {
    _todosDoDate = _todos.values
        .where((todo) =>
    todo.doDate != null && todo.doDate!.isAfter(DateTime.now()))
        .toList()
      ..sort((a, b) => a.doDate!.compareTo(b.doDate!));
    notifyListeners();
  }

  //
  Future<void> insertTodo(TodoModel todo, int index) async {
    await _todolistsService.insertTodo(todo, todo.todolistId);
    TodolistModel parent = _todolists.firstWhere((t) =>
    t.id == todo.todolistId);
    if (index >= parent.todos.length || index < 0) index = parent.todos.length;
    parent.todos.insert(index, todo);
    _todos[todo.id] = todo;
    if (todo.doDate != null && todo.doDate!.isAfter(DateTime.now())) {
      _todosDoDate.add(todo);
      _todosDoDate.sort((a, b) => a.doDate!.compareTo(b.doDate!));
    }
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
    if (todo.doDate != null && todo.doDate!.isAfter(DateTime.now())) {
      if (!_todosDoDate.contains(todo)) _todosDoDate.add(todo);
      _todosDoDate.sort((a, b) => a.doDate!.compareTo(b.doDate!));
    }

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
    _todosDoDate.remove(todo);

    notifyListeners();
    return removed;
  }

  //
  Future<void> undoRemoveTodo(RecentlyRemoved<TodoModel> removed) async {
    await insertTodo(removed.item, removed.index);
    notifyListeners();
  }
}