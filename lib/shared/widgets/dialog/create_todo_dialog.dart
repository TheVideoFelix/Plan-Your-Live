import 'package:flutter/material.dart';
import 'package:plan_your_live/models/todolist/todo_model.dart';
import 'package:plan_your_live/providers/todolist.dart';
import 'package:plan_your_live/shared/widgets/dialog/base_dialog.dart';
import 'package:provider/provider.dart';

class CreateTodoDialog extends StatefulWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final TodoModel? todo;
  CreateTodoDialog({this.todo, super.key});

  @override
  CreateTodoDialogState createState() => CreateTodoDialogState();
}

class CreateTodoDialogState extends State<CreateTodoDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  @override
  void initState() {
    super.initState();
    widget._titleController.text = widget.todo?.title ?? '';
    widget._descriptionController.text = widget.todo?.description ?? '';
    _selectedDate = widget.todo?.doDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final todolistProvider = Provider.of<TodolistNotifier>(context);
    return BaseDialog(
        formKey: _formKey,
        height: 400,
        title: "Create Todo",
        saveAction: () async {
          final NavigatorState navigator = Navigator.of(context);
          if (_formKey.currentState!.validate()) {
            if (widget.todo != null) {
              widget.todo!.title = widget._titleController.text;
              widget.todo!.description = widget._descriptionController.text;
              widget.todo!.doDate = _selectedDate;
              await todolistProvider.updateTodo(widget.todo!);
            } else {
              if (todolistProvider.todolist == null) return;
              await todolistProvider.addTodo(TodoModel(title: widget._titleController.text, isChecked: false, doDate: _selectedDate, todolistId: todolistProvider.todolist!.id));
            }
            navigator.pop();
          }
        },
        children: [
          TextFormField(
            controller: widget._titleController,
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
            controller: widget._descriptionController,
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
          TextFormField(
            readOnly: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Select date',
              labelText: 'Date',
              suffixIcon: Icon(Icons.calendar_month),
            ),
            onTap: () => _selectDate(context),
            validator: (value) {
              if (_selectedDate != null &&
                  _selectedDate!.isBefore(DateTime.now())) {
                return 'The Date must be in the future.';
              }
              return null;
            },
            controller: TextEditingController(
              text: _selectedDate == null
                  ? ''
                  : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
            ),
          ),
        ]);
  }
}
