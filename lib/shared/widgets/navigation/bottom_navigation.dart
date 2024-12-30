import 'package:flutter/material.dart';
import 'package:plan_your_live/providers/navigation.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});


  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(context, Icons.list, 1, "Todolists"),
          _buildNavItem(context, Icons.home, 0, "Home"),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, int index, String label) {
    final navigationProvider = Provider.of<NavigationNotifier>(context);
    final isSelected = navigationProvider.page == index;

    return GestureDetector(
      onTap: () {
        navigationProvider.pageController.jumpToPage(index);
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Theme.of(context).colorScheme.secondary : Colors.white,
            ),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Theme.of(context).colorScheme.secondary : Colors.white,
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );


  }

}