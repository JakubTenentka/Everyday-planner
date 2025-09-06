import 'package:flutter/material.dart';
import 'package:to_do_flutter/services/item_service.dart';

import '../../model/item_class.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  List<Item> items = [];
  final TextEditingController _newItemNameController = TextEditingController();
  ItemService itemService = ItemService();

  @override
  void initState() {
    super.initState();
    _getItems();
  }

  void _getItems() async {
    final List<Item> fetchedItems = await itemService.fetchAllItems();
    setState(() {
      items = fetchedItems;
    });
  }

  void _addNewItem() {
    setState(() {
      items.insert(0, Item(name: '', isEditing: true, count: 1));
    });
  }

  void _saveItemName(Item item, String newName) {
    setState(() {
      item.name = newName;
      item.isEditing = false;
    });
  }

  void _cancelAddItem(Item item) {
    setState(() {
      // Jeśli nazwa jest pusta i anulowano, usuń ten tymczasowy element
      if (item.name.isEmpty) {
        items.remove(item);
      } else {
        // Jeśli coś wpisano, ale anulowano, po prostu wyjdź z trybu edycji
        item.isEditing = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista Zakupów'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addNewItem,
          ),
          IconButton(
              icon: Icon(Icons.sync),
              onPressed: () {
                setState(() {
                  _getItems();
                });
              }),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          if (item.isEditing) {
            // ----- TRYB EDYCJI -----
            _newItemNameController.text = item.name;
            _newItemNameController.selection = TextSelection.fromPosition(
                TextPosition(offset: _newItemNameController.text.length));

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
                title: TextField(
                  controller: _newItemNameController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Nazwa produktu',
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) {
                    if (value.trim().isNotEmpty) {
                      _saveItemName(item, value.trim());
                    } else {
                      _cancelAddItem(item);
                    }
                  },
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () {
                        if (_newItemNameController.text.trim().isNotEmpty) {
                          _saveItemName(
                              item, _newItemNameController.text.trim());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Nazwa nie może być pusta.')),
                          );
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        _cancelAddItem(item);
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            // ----- TRYB WYŚWIETLANIA (Twój istniejący kod) -----
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
                onTap: () {
                  setState(() {
                    item.isEditing = true;
                  });
                },
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
          }
        },
      ),
    );
  }
}
