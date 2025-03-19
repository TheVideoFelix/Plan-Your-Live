import 'package:flutter/material.dart';
import 'package:plan_your_live/shared/utils/const.dart';

class TodoCard extends StatelessWidget {
  final String id;
  final String title;
  final bool isChecked;
  final VoidCallback onTap;
  final VoidCallback onPressed;
  final DismissDirectionCallback onDismissed;

  const TodoCard({super.key,
    required this.id,
    required this.title,
    required this.isChecked,
    required this.onTap,
    required this.onPressed,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
        fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
        color: isChecked ? Constants.todoIsChecked : Constants.text,
        decoration: isChecked ? TextDecoration.lineThrough : TextDecoration.none);

    return GestureDetector(
      onTap: onTap,
      onLongPress: onPressed,
      child: Dismissible(
          key: Key(id),
          direction: DismissDirection.startToEnd,
          onDismissed: onDismissed,
          child: Card(
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: Padding(padding: const EdgeInsets.all(5),
              child: SizedBox(
                height: 100,
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                      decoration: BoxDecoration(
                        color: isChecked ? Theme.of(context).colorScheme.onPrimary : Colors.transparent,
                        border: Border.all(color: Theme.of(context).colorScheme.onPrimary, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title,
                                style: textStyle,
                                overflow: TextOverflow.ellipsis
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

}