import 'package:flutter/material.dart';
import 'package:plan_your_live/layout/base.dart';
import 'package:plan_your_live/providers/navigation.dart';
import 'package:plan_your_live/shared/widgets/button/setting_button.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationNotifier>(context);

    return BaseLayout(
      header: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(onPressed: () {
          navigationProvider.jumpToPage(navigationProvider.previousPage);
        }, icon: const Icon(Icons.arrow_back),
        iconSize: 25,
        ),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text("Settings", style: Theme.of(context).textTheme.titleMedium),
              Text("Privacy and Data", style: Theme.of(context).textTheme.titleSmall),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SettingButton(title: "Delete userdata!", description: "Deletes all saved data!", onPressed: () { print("deleted data!");}),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}