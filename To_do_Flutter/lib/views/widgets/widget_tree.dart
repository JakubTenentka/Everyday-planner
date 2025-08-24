import 'package:flutter/material.dart';
import '../../data/notifiers.dart';
import '../pages/tags_page.dart';
import '../pages/welcome_page.dart';
import 'navbar_widget.dart';

List<Widget> pages = [
  WelcomePage(),
  TagsPage(),
];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: ValueListenableBuilder(
        valueListenable: selectedpageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),
      bottomNavigationBar: NavbarWidget(),
    );
  }
}
