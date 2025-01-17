import 'package:flutter/material.dart';
import 'package:plan_your_live/models/todolist/todolist_model.dart';
import 'package:plan_your_live/providers/todolist.dart';
import 'package:plan_your_live/shared/widgets/dialog/base_dialog.dart';
import 'package:provider/provider.dart';

class CreateTodolistDialog extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController;
  final TextEditingController _descriptionController;

  final TodolistModel? todolist;

  CreateTodolistDialog({this.todolist, super.key})
      : _titleController = TextEditingController(text: todolist?.title ?? ''),
        _descriptionController = TextEditingController(text: todolist?.description ?? '');

  @override
  Widget build(BuildContext context) {
    final todolistProvider = Provider.of<TodolistNotifier>(context);
    return BaseDialog(
        formKey: _formKey,
        height: 300,
        title: "Create Todolist",
        saveAction: () async {
          if (_formKey.currentState!.validate()) {
            if(todolist != null) {
              todolist!.title = _titleController.text;
              todolist!.description = _descriptionController.text;
              await todolistProvider.updateTodolist(todolist!);
            } else {
              await todolistProvider.addTodolist(
                  TodolistModel(title: _titleController.text, description: _descriptionController.text));
            }
            Navigator.of(context).pop();
          }
        },
        children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Title',
              labelText: 'Title',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              } else if (value.length > 255) {
                return 'Text cannot be more than 255 characters';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Description',
              labelText: 'Description',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return null;
              } else if (value.length > 255) {
                return 'Text cannot be more than 255 characters';
              }
              return null;
            },
          ),
        ]
    );
  }
}

/*
* FutureBuilder(
            future: todolistProvider.fetchAndSetTodolists(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.error != null) {
                return const Center(
                  child: Text('An error occurred!'),
                );
              } else {
                return Consumer<TodolistNotifier>(
                    builder: (ctx, todolistNotifier, _) {
                  if (todolistNotifier.todolists.isEmpty) {
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
                                navigationProvider.pageController
                                    .jumpToPage(2)
                              },
                              onPressed: () => {print("Pressed")},
                              onDismissed: (DismissDirection direction) {
                                todolistProvider.removeTodolist(todolist.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: const Text('Todolist removed'),
                                        action: SnackBarAction(
                                            label: 'Undo',
                                            onPressed: () async {
                                              await todolistProvider
                                                  .undoRemoveTodolist();
                                            }))
                                );
                              }
                          );
                        }
                    );
                  }



                      /*SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: List.generate(
                              todolistNotifier.todolists.length, (index) {
                            final todolist = todolistNotifier.todolists[index];
                            return TodolistCard(
                                id: todolist.id,
                                title: todolist.title,
                                description: todolist.description,
                                onTap: () => {
                                      navigationProvider.pageController
                                          .jumpToPage(2)
                                    },
                                onPressed: () => {print("Pressed")},
                                onDismissed: (DismissDirection direction) {
                                  todolistProvider.removeTodolist(todolist.id);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: const Text('Todolist removed'),
                                    action: SnackBarAction(
                                        label: 'Undo',
                                        onPressed: () async {
                                           await todolistProvider.undoRemoveTodolist();
                                        }))
                                  );
                                }
                            );
                          }),
                        ),
                      ),
                    );*/
                  }
                });
              }
            })

          LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(
                  100,
                  (index) => TodolistCard(
                      id: '$index',
                      title: 'Item$index',
                      description: (index % 2) == 0
                          ? 'Test testbdf f d dfgdfgdfgdge'
                          : null,
                      onTap: () => navigationProvider.pageController.jumpToPage(2),
                      onPressed: () => {
                        print("Pressed")
                      },
                      onDismissed: (DismissDirection direction) => print("Dismissed"),
                  )
                  ),
              )
          ),
         );
      }),*/