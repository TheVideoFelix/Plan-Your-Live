import 'package:flutter/material.dart';

class BaseLayout extends StatelessWidget {
  final Widget? header;
  final Widget body;
  final Widget? footer;


  const BaseLayout({
    this.header,
    required this.body,
    this.footer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header is PreferredSizeWidget ? header as PreferredSizeWidget : null,
      body: Column(
        children: [
          if (header != null &&  header is! PreferredSizeWidget) header!,
          Expanded(child: body),
          if (footer != null) footer!,
        ],
      ),
    );
  }
}