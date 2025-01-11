import 'package:flutter/material.dart';
import 'package:plan_your_live/shared/widgets/dialog/base_dialog.dart';

class CreateTodoDialog extends StatefulWidget {
  const CreateTodoDialog({super.key});

  @override
  _CreateTodoDialogState createState() => _CreateTodoDialogState();
}

class _CreateTodoDialogState extends State<CreateTodoDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;

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
    return BaseDialog(
        formKey: _formKey,
        height: 400,
        title: "Create Todo",
        saveAction: () => {
              if (_formKey.currentState!.validate())
                {Navigator.of(context).pop()}
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
              if (_selectedDate != null && _selectedDate!.isBefore(DateTime.now())) {
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
