import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_flutter/providers/item_provider.dart';

class ShoppingListPage extends ConsumerWidget {
  const ShoppingListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemListAsyncProvider = ref.watch(itemProvider);
    TextEditingController textEditingController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista Zakupów'),
        ),
        body: itemListAsyncProvider.when(
            data: (items) {
              if (items.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text('Brak danych. Dodaj produkt klikając "+"'),
                    ),
                    TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                          labelText: 'Dodaj produkt',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              ref
                                  .read(itemProvider.notifier)
                                  .addItem(textEditingController.text);
                            },
                          )),
                    )
                  ],
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Card(
                              margin: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              child: ListTile(
                                leading: Checkbox(
                                  value: item.isChecked,
                                  onChanged: (bool? value) {
                                    if (value != null) {
                                      ref
                                          .read(itemProvider.notifier)
                                          .toggleItemChecked(item.name, value);
                                    }
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
                                              ref
                                                  .read(itemProvider.notifier)
                                                  .changeItemCount(
                                                      item.name, false);
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
                                        ref
                                            .read(itemProvider.notifier)
                                            .changeItemCount(item.name, true);
                                      },
                                    ),
                                  ],
                                ),
                              ));
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 50.0, horizontal: 20),
                    child: TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                          labelText: 'Dodaj produkt',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              ref
                                  .read(itemProvider.notifier)
                                  .addItem(textEditingController.text);
                            },
                          )),
                    ),
                  )
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      const Icon(Icons.warning_amber_rounded,
                          color: Colors.orange, size: 50),
                      const SizedBox(height: 10),
                      Text(
                        error.toString(),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.orange),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('OK, rozumiem'),
                        onPressed: () {
                          ref.read(itemProvider.notifier).refreshItems();
                        },
                      ),
                    ]))));
  }
}
