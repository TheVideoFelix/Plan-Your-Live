import 'package:flutter/material.dart';
import 'package:plan_your_live/layout/base.dart';
import 'package:plan_your_live/providers/todolist.dart';
import 'package:plan_your_live/shared/widgets/appbar/main_appbar.dart';
import 'package:plan_your_live/shared/widgets/collaspsibles/collapsible_list.dart';
import 'package:plan_your_live/shared/widgets/lists/todo_list_widget.dart';
import 'package:plan_your_live/shared/widgets/lists/todolist_list_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todolistProvider = Provider.of<TodolistNotifier>(context);

    return BaseLayout(
      header: const MainAppBar(title: "Home Screen"),
      body: Container(
        constraints: const BoxConstraints.expand(),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CollapsibleList(title: "Due Todos", itemCount: todolistProvider.todosDoDate.length, list: TodosListWidget(todos: todolistProvider.todosDoDate.take(10).toList(), emptyText: "No todos available.")),
                    CollapsibleList(title: "Favorite Todolists", itemCount: todolistProvider.favoriteTodolists.length, list: TodolistsListWidget(todolists: todolistProvider.favoriteTodolists, emptyText: "No favorite todolists yet, added one."), singleItemHeight: 106.0),
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}