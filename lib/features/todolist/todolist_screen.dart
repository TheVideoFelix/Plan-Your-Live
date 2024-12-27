import 'package:flutter/material.dart';
import 'package:plan_your_live/layout/base.dart';
import 'package:plan_your_live/providers/navigation.dart';
import 'package:provider/provider.dart';

class TodolistScreen extends StatelessWidget {
  const TodolistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationNotifier>(context);

    return BaseLayout(
      header: AppBar(
        automaticallyImplyLeading: true,
      leading: IconButton(onPressed: () {
        navigationProvider.pageController.jumpToPage(1);
      }, icon: const Icon(Icons.arrow_back), iconSize: 25,)),
      body: LayoutBuilder(builder: (context, constraints) {
        return  Column(
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  child: Padding(padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Todolist Name', style: TextStyle(fontSize: 28.0)),
                      Text('discrption of todolist', style: TextStyle(fontSize: 15))
                    ],
                  ),
                  ),
                )
              ],
            ),
            Expanded(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: List.generate(20, (index) => GestureDetector(
                        onTap: () {
                          const snackBar = SnackBar(
                            content: Text('Tapped'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        onLongPress: () {
                          const snackBar = SnackBar(
                            content: Text('Pressed'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: Dismissible(key: const Key('ds'),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) {
                              const snackBar = SnackBar(
                                content: Text('Dismissed'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                            },
                            child: Card(
                              child: Padding(padding: const EdgeInsets.all(5),
                              child: SizedBox(
                                height: 100,
                                child: Row(
                                  children: [
                                    //const Checkbox(value: true, onChanged: null),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                      decoration: BoxDecoration(
                                        color: (index % 3) == 0 ? Colors.orange : Colors.transparent,
                                        border: Border.all(color: Colors.orange, width: 2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Text$index fdfiosion n dsf sd sdfsd sdfsdf sd sd fdsffsdf sf sd sd sdfsfeion ionfo nsio nsdonf oisd ',
                                                style: TextStyle(fontSize: 24.0, color: (index % 3) == 0 ? Colors.grey : Colors.black,
                                                    decoration: (index % 3) == 0 ? TextDecoration.lineThrough : TextDecoration.none),
                                                overflow: TextOverflow.ellipsis)
                                          ],
                                        )
                                    ),
                                  ],
                                ),
                              ),
                              ),
                            )),
                      )),
                    ),
                  ),
                )),

          ],
          );
      }),
    );
  }

}