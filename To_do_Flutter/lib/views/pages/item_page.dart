import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_flutter/providers/item_provider.dart';

class ShoppingListPage extends ConsumerWidget {
  const ShoppingListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemListAsyncProvider = ref.watch(itemProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista Zakupów'),
        ),
        body: itemListAsyncProvider.when(
          data: (items) {
            if (items.isEmpty) {
              return const Center(
                child: Text('Brak danych. Dodaj produkt klikając "+"'),
              );
            }
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Card(
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      child: ListTile(
                        leading: Checkbox(
                          value: item.isChecked,
                          onChanged: (bool? value) {
                            // TODO Zaznaczanie zrobienia taska
                            /* setState(() {
                            item.isChecked = value ?? false;
                          });*/
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
                                      //TODO Zmniejszanie ilości produktu
                                      /*setState(() {
                                item.count--;
                              });*/
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
                                // TODO Zwiększanie ilości produktu
                                /*setState(() {
                                item.count++;
                              });*/
                              },
                            ),
                          ],
                        ),
                      ));
                });
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) =>
              Center(/* TODO ... obsługa błędu ... */),
        ));
  }
}
