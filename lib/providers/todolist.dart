import 'package:flutter/material.dart';
import 'package:plan_your_live/models/todolist/todolist_model.dart';
import 'package:plan_your_live/services/todolists_service.dart';

class TodolistNotifier extends ChangeNotifier {
  final TodolistsService _todolistsService = TodolistsService();

  List<TodolistModel> _todolists = [];
  TodolistModel? _todolist;
  TodolistModel? _recentlyRemovedTodolist;
  int _recentlyRemovedTodolistIndex = 0;
  bool _isLoading = false;

  List<TodolistModel> get todolists {
    return [..._todolists];
  }

  TodolistModel? get todolist => _todolist;

  bool get isLoading => _isLoading;

  void clear() {
    _todolists = [];
    _todolist = null;
    _isLoading = false;
  }

  Future<void> fetchAndSetTodolists() async {
    _isLoading = true;
    List<TodolistModel>? result = await _todolistsService.fetchTodolists();
    _todolists = result ?? [];
    _isLoading = false;
    notifyListeners();
  }

  Future<void> insertTodolist(TodolistModel todolist, int index) async {
    await _todolistsService.insertTodolist(todolist);
    _todolists.insert(index, todolist);
    notifyListeners();
  }

  Future<void> addTodolist(TodolistModel todolist) async {
    await _todolistsService.insertTodolist(todolist);
    _todolists.add(todolist);
    notifyListeners();
  }

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
    notifyListeners();
  }

  Future<void> undoRemoveTodolist() async {
    if (_recentlyRemovedTodolist != null) {
      await insertTodolist(_recentlyRemovedTodolist!, _recentlyRemovedTodolistIndex);
      _recentlyRemovedTodolist = null;
      notifyListeners();
    }
  }

}