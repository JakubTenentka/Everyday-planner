import 'package:flutter/material.dart';

import '../../data/notifiers.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedpageNotifier,
      builder: (context, selectedPage, child) {
        return NavigationBar(
          destinations: [
            NavigationDestination(icon: Icon(Icons.task_alt), label: 'Zadania'),
            NavigationDestination(icon: Icon(Icons.tag), label: 'Kategorie')
          ],
          onDestinationSelected: (int value) {
            selectedpageNotifier.value = value;
          },
          selectedIndex: selectedPage,
        );
      },
    );
  }
}
