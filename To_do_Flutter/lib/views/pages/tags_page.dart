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
  late Future<List<Tag>> tags;

  Future<List<Tag>> fetchAllTags() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/api/getTags'),
    );
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
    tags = fetchAllTags();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: <Widget>[
          TagWidget(),
        ],
      ),
    );
  }
}
