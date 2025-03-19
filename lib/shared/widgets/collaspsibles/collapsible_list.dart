import 'package:flutter/material.dart';

class CollapsibleList extends StatefulWidget {
  final String title;
  final int itemCount;
  final Widget list;
  final double singleItemHeight;

  const CollapsibleList({
    super.key,
    required this.title,
    double? singleItemHeight,
    required this.itemCount,
    required this.list,
  }) : singleItemHeight = singleItemHeight ?? 117.0 ;

  @override
  State<StatefulWidget> createState() => _CollapsibleListSate();

}

class _CollapsibleListSate extends State<CollapsibleList> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => _isExpanded = !(_isExpanded)),
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Text(widget.title, style: Theme.of(context).textTheme.titleSmall),
                Icon(_isExpanded ? Icons.expand_less : Icons.expand_more)
              ],
            ),
          ),
        ),
        AnimatedContainer(
            duration: const Duration(microseconds: 300),
          curve: Curves.easeInOut,
          height: _isExpanded ? _calculateListHeight() : 0,
          child: Stack(
            children: [
              widget.list,
              if (_isExpanded && widget.itemCount > 3)
                Positioned(
                  bottom: 0,
                    left: 0,
                    right: 0,
                    height: 30,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    gradient: LinearGradient(
                      colors: [Theme.of(context).colorScheme.onPrimary.withOpacity(0), Theme.of(context).colorScheme.onPrimary.withOpacity(0.1)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter
                    )
                  ),
                ))
            ],
          ),
        )
      ],
    );
  }

  double _calculateListHeight() {
    double singleItemHeight = widget.singleItemHeight;
    final int itemCountHeight = (widget.itemCount > 3 ? 3 : widget.itemCount);
    return (itemCountHeight == 0 ? 1 : itemCountHeight) * singleItemHeight;
  }
}