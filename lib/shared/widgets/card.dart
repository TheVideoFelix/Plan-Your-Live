import 'package:flutter/material.dart';

class TodolistCard extends StatelessWidget {
  final String title;
  final String? description;

  const TodolistCard({required this.title, this.description, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: SizedBox(
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
              child:
              Padding(
                  padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: const TextStyle(fontSize: 20.0)),
                        if (description != null) Text(description!, style: const TextStyle(fontSize: 12.0)),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () => {
                            print('pressed')
                          }, icon: const Icon(Icons.star_border),
                          alignment: Alignment.center, padding: const EdgeInsets.all(4),)
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
