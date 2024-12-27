import 'package:flutter/cupertino.dart';
import 'package:plan_your_live/providers/navigation.dart';
import 'package:plan_your_live/providers/counter.dart';
import 'package:provider/provider.dart';

class AppProvider extends StatelessWidget {
  final Widget child;

  const AppProvider({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider (
      providers: [
        ChangeNotifierProvider(create: (_) => CounterNotifier()),
        ChangeNotifierProvider(create: (_) => NavigationNotifier())
      ],
      child: child,
    );
  }

}