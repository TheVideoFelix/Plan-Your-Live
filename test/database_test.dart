import 'package:flutter_test/flutter_test.dart';
import 'package:plan_your_live/models/todolist/todolist_model.dart';
import 'package:plan_your_live/services/todolists_service.dart';
import 'package:plan_your_live/shared/db/database_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:uuid/uuid.dart';

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
        title: "Test Todolist", todos: []);

    int id = await todolistsService.insertTodolist(todolist);
    expect(id, isNotNull);

    final db = await databaseService.database;
    List<Map<String, dynamic>> result = await db.query('todolists', where: 'id = ?', whereArgs: [
      todolist.id
    ]);

    expect(result.isNotEmpty, true);
    expect(result.first['title'], todolist.title);
  });


}