import 'package:flutter/material.dart';
import 'package:plan_your_live/layout/base.dart';
import 'package:plan_your_live/providers/navigation.dart';
import 'package:plan_your_live/providers/todolist.dart';
import 'package:plan_your_live/shared/utils/dialog.dart';
import 'package:plan_your_live/shared/widgets/card/todolist_card.dart';
import 'package:plan_your_live/shared/widgets/dialog/create_todolist_dialog.dart';
import 'package:provider/provider.dart';

class TodolistsScreen extends StatefulWidget {
  const TodolistsScreen({super.key});

  @override
  _TodolistsScreen createState() => _TodolistsScreen();
}

class _TodolistsScreen extends State<TodolistsScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<TodolistNotifier>(context, listen: false).fetchAndSetTodolists();
  }

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationNotifier>(context);
    final todolistProvider = Provider.of<TodolistNotifier>(context);

    return BaseLayout(
        actionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          onPressed: () {
            DialogUtils.show(context, CreateTodolistDialog());
          },
          child: const Icon(Icons.add),
        ),
        header: AppBar(title: Text('Todolists', style: Theme.of(context).textTheme.displayLarge,)),
        body: Consumer<TodolistNotifier>(builder: (ctx, todolistNotifier, _) {
          if (todolistNotifier.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (todolistNotifier.todolists.isEmpty) {
            return const Center(
              child: Text('No todolists available. Create one!'),
            );
          } else {
            return ListView.builder(
                itemCount: todolistProvider.todolists.length,
                itemBuilder: (context, index) {
                  final todolist = todolistNotifier.todolists[index];
                  return TodolistCard(
                      id: todolist.id,
                      title: todolist.title,
                      description: todolist.description,
                      onTap: () =>
                          {
                            navigationProvider.pageController.jumpToPage(2)
                          },
                      onPressed: () => {
                        DialogUtils.show(context, CreateTodolistDialog(todolist: todolist))
                      },
                      onDismissed: (DismissDirection direction) {
                        todolistProvider.removeTodolist(todolist.id);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text('Todolist removed'),
                            action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () async {
                                  await todolistProvider.undoRemoveTodolist();
                                })));
                      });
                });
          }
        }));
  }
}
