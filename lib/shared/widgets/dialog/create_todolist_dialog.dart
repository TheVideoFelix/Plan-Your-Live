import 'package:flutter/material.dart';
import 'package:plan_your_live/models/todolist/todolist_model.dart';
import 'package:plan_your_live/providers/navigation.dart';
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
    final navigationProvider = Provider.of<NavigationNotifier>(context);

    return BaseDialog(
        formKey: _formKey,
        height: 300,
        title: "Create Todolist",
        saveAction: () async {
          final NavigatorState navigator = Navigator.of(context);
          if (_formKey.currentState!.validate()) {
            if(todolist != null) {
              todolist!.title = _titleController.text;
              todolist!.description = _descriptionController.text;
              await todolistProvider.updateTodolist(todolist!);
            } else {
              TodolistModel newTodolist = TodolistModel(title: _titleController.text, description: _descriptionController.text);
              await todolistProvider.addTodolist(
                  newTodolist);
              await todolistProvider.fetchAndSetTodolist(newTodolist);
              navigationProvider.jumpToPage(2);
            }
            navigator.pop();
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