import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_flutter/views/widgets/appbar_widget.dart';
import '../../providers/tags_provider.dart';
import '../widgets/tag_widget.dart';

class TagsPage extends ConsumerWidget {
  const TagsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagServiceAsyncValue = ref.watch(tagsProvider);

    return Scaffold(
      appBar: AppbarWidget(title: 'Twoje kategorie'),
      body: tagServiceAsyncValue.when(
        data: (tags) {
          if (tags.isEmpty) {
            return const Center(
              child: Text('Brak danych'),
            );
          }
          return GridView.count(
              childAspectRatio: 2.0,
              padding: EdgeInsets.all(20.0),
              crossAxisSpacing: 15.0,
              mainAxisSpacing: 15.0,
              crossAxisCount: 2,
              children: List.generate(
                tags.length,
                (index) {
                  return TagWidget(
                    id: tags[index].id,
                    tagName: tags[index].tagName,
                  );
                },
              ));
        },
        loading: () => const CircularProgressIndicator(),
        error: (err, stack) => Text('Błąd: $err'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTagDialog(context, ref);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAddTagDialog(BuildContext context, WidgetRef ref) {
    TextEditingController controllerTagName = TextEditingController();
    String? newTagName;
    return showDialog<void>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text('Podaj nazwę kategorii'),
            content: TextField(
              controller: controllerTagName,
              decoration: InputDecoration(
                hintText: 'Nazwa',
              ),
              onChanged: (value) {
                newTagName = value.trim();
              },
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  Navigator.of(dialogContext).pop();
                },
                child: Text('Anuluj'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(dialogContext).pop();
                  try {
                    final String? response = await ref
                        .read(tagServiceProvider)
                        .createTag(newTagName ?? "");
                    if (response == null) {
                      ref.refresh(tagsProvider);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Dodano')));
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(response)));
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text('Dodaj'),
              )
            ],
          );
        });
  }
}
