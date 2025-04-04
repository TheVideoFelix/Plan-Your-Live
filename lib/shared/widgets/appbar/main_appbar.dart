import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plan_your_live/providers/navigation.dart';
import 'package:provider/provider.dart';

class MainAppBar extends StatelessWidget {
  final String title;

  const MainAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationNotifier>(context);

    return AppBar(title:
    Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.displayLarge,),
        IconButton(onPressed: () {
          navigationProvider.jumpToPage(3);
        }, icon: const Icon(Icons.settings_outlined))
      ],));
  }
}