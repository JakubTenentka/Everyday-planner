import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:to_do_flutter/services/tag_service.dart';
import 'package:to_do_flutter/views/widgets/appbar_widget.dart';

import '../../model/tag_class.dart';
import '../widgets/tag_widget.dart';

class TagsPage extends StatefulWidget {
  const TagsPage({super.key});

  @override
  State<TagsPage> createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {
  late Future<List<Tag>> _futureTags;

  TagService tagService = TagService();

  @override
  void initState() {
    super.initState();
    _futureTags = tagService.fetchAllTags();
  }

  void _refreshTags() {
    setState(() {
      _futureTags = tagService.fetchAllTags();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: 'Twoje kategorie'),
      body: FutureBuilder(
        future: _futureTags,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Błąd: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final tags = snapshot.data!;
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
          } else {
            return const Center(
              child: Text('Brak danych'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTagDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAddTagDialog(BuildContext context) {
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
                    final http.Response response =
                        await tagService.createTag(newTagName!);
                    if (response.statusCode == 201) {
                      _refreshTags();
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
