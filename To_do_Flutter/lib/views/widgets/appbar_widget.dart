import 'package:flutter/material.dart';
import 'package:to_do_flutter/views/pages/item_page.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShoppingListPage()),
            );
          },
          icon: Icon(Icons.shopping_cart),
        )
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}
