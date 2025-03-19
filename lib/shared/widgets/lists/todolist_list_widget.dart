import 'package:flutter/material.dart';
import 'package:plan_your_live/models/todolist/recently_removed.dart';
import 'package:plan_your_live/models/todolist/todolist_model.dart';
import 'package:plan_your_live/providers/navigation.dart';
import 'package:plan_your_live/providers/todolist.dart';
import 'package:plan_your_live/shared/utils/dialog.dart';
import 'package:plan_your_live/shared/widgets/card/todolist_card.dart';
import 'package:plan_your_live/shared/widgets/dialog/create_todolist_dialog.dart';
import 'package:plan_your_live/shared/widgets/lists/base_list_widget.dart';
import 'package:provider/provider.dart';

class TodolistsListWidget extends StatelessWidget {
  final List<TodolistModel> todolists;
  final String emptyText;

  const TodolistsListWidget({
    super.key,
    required this.todolists,
    required this.emptyText
  });

  @override
  Widget build(BuildContext context) {
    final todolistProvider = Provider.of<TodolistNotifier>(context);
    final navigationProvider = Provider.of<NavigationNotifier>(context);

    return BaseListWidget<TodolistModel>(
        items: todolists,
        emptyText: emptyText,
        itemBuilder: (context, todolist) {
          return TodolistCard(
              id: todolist.id,
              title: todolist.title,
              description: todolist.description,
              isFavorite: todolist.isFavorite,
              onTap: () async
              {
                todolistProvider.fetchAndSetTodolist(todolist);
                navigationProvider.jumpToPage(2);
              },
              onPressed: () =>
              {
                DialogUtils.show(
                    context, CreateTodolistDialog(todolist: todolist))
              },
              onFavorite: () =>
              {
                todolistProvider.favoriteTodolist(todolist)
              },
              onDismissed: (DismissDirection direction) async {
                final ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);
                final TextStyle? textTheme = Theme.of(context).textTheme.labelMedium;

                RecentlyRemoved<TodolistModel> removed = await todolistProvider.removeTodolist(todolist);
                scaffoldMessenger.showSnackBar(SnackBar(
                    content: Text('Todolist removed', style: textTheme),
                    action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () async {
                          await todolistProvider.undoRemoveTodolist(removed);
                        })));
              });
        }
    );
  }
}