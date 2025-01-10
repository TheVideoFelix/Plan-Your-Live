import 'package:flutter/material.dart';

class DialogUtils {

  static Future<dynamic> show(BuildContext context, Widget dialog) {
    return showDialog(
        context: context,
        builder: (context) => dialog);
  }
}