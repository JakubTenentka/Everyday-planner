import 'package:flutter/material.dart';

import '../../model/item_class.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  final List<Item> items = [
    Item(name: 'jablka'),
    Item(name: 'pasta do zebów'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return Card(
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: ListTile(
              leading: Checkbox(
                value: item.isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    item.isChecked = value ?? false;
                  });
                },
              ),
              title: Text(item.name),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: item.count > 0
                        ? () {
                            setState(() {
                              item.count--;
                            });
                          }
                        : null,
                  ),
                  Text(
                    "${item.count}",
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        item.count++;
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
