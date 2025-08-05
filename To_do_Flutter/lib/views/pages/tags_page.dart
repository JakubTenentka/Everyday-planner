import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/tag_class.dart';
import '../widgets/tag_widget.dart';

class TagsPage extends StatefulWidget {
  const TagsPage({super.key});

  @override
  State<TagsPage> createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {
  late Future<List<Tag>> _futureTags;

  Future<List<Tag>> fetchAllTags() async {
    print('Rozpoczynam zapytanie HTTP...');
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/api/getTags'),
    );
    print('Odpowiedź otrzymana: ${response.statusCode}');
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      List<Tag> tags = jsonList
          .map(((jsonItem) => Tag.fromJson(jsonItem as Map<String, dynamic>)))
          .toList();
      return tags;
    } else if (response.statusCode == 204) {
      return [];
    } else {
      throw Exception('Failed to load Tags');
    }
  }

  @override
  void initState() {
    super.initState();
    _futureTags = fetchAllTags();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
    );
  }
}
