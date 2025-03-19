import 'package:flutter/material.dart';

class BaseDialog extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final double height;
  final String title;
  final VoidCallback saveAction;
  final List<Widget> children;

  const BaseDialog({
    required this.formKey,
    required this.height,
    required this.title,
    required this.saveAction,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SizedBox(
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  ...children,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () => {
                                Navigator.of(context).pop(),
                              },
                          child: const Text("Cancel")),
                      TextButton(
                          onPressed: saveAction, child: const Text("Save")),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
