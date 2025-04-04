import 'package:flutter/material.dart';
import 'package:plan_your_live/shared/utils/const.dart';

class SettingButton extends StatelessWidget {
  final String title;
  final String? description;
  final VoidCallback onPressed;

  const SettingButton({
    super.key,
    required this.title,
    this.description,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          height: 50,
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              if (description != null || description != "")
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(description ?? "",
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.labelMedium!.fontSize,
                          color: Constants.text)),
                ),
            ],
          )),
    );
  }
}
