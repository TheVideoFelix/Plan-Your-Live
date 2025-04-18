import 'package:flutter/material.dart';
import 'package:plan_your_live/shared/widgets/card/base_card.dart';

class TodolistCard extends StatelessWidget {
  final String id;
  final String title;
  final String? description;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onPressed;
  final VoidCallback onFavorite;
  final DismissDirectionCallback onDismissed;

  const TodolistCard({
    required this.id,
    required this.title,
    this.description,
    required this.isFavorite,
    required this.onTap,
    required this.onPressed,
    required this.onFavorite,
    required this.onDismissed,
    super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onPressed,
      child: Dismissible(
          key: Key(id),
          direction: DismissDirection.startToEnd,
          onDismissed: onDismissed,
          child: BaseCard(
              height: 100,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 34.0,
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    child: Text(
                      title[0],
                      style: const TextStyle(fontSize: 24.0),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title, style: Theme.of(context).textTheme.bodyLarge, overflow: TextOverflow.ellipsis),
                              if (description != null || description != "")
                                Text(description!,
                                    style: Theme.of(context).textTheme.bodySmall),
                            ],
                          ),
                        )),
                        Column(
                          children: [
                            IconButton(
                              onPressed: onFavorite,
                              icon: isFavorite ? const Icon(Icons.star) : const Icon(Icons.star_border),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(4),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ))
      ),
    );
  }
}
