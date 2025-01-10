import 'package:flutter/material.dart';
import 'package:plan_your_live/shared/widgets/dialog/base_dialog.dart';

class CreateDialog extends StatelessWidget {
  final _fromKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  CreateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
        formKey: _fromKey,
        height: 300,
        title: "Create Todolist",
        saveAction: () => {
          if (_fromKey.currentState!.validate()) {
            Navigator.of(context).pop()
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
                return 'Please enter some text';
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