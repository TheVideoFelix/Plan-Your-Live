import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget {
  final double height;
  final Widget child;

  const BaseCard({
    required this.height,
    required this.child,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: SizedBox(
        height: height,
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: child
        ),
      ),
    );
  }

}