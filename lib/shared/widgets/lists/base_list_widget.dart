import 'package:flutter/material.dart';

class BaseListWidget<T> extends StatelessWidget {
  final List<T> items;
  final String emptyText;
  final Widget Function(BuildContext, T) itemBuilder;

  const BaseListWidget({
    super.key,
    required this.items,
    required this.emptyText,
    required this.itemBuilder
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Text(emptyText, style: Theme.of(context).textTheme.bodyMedium),
      );
    } else {
      return ListView.builder(
        itemCount: items.length,
          itemBuilder: (context, index) {
          return itemBuilder(context, items[index]);
          }
      );
    }
  }
}