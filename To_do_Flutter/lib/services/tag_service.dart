import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/tag_class.dart';

class TagService {
  final String baseUrl = 'http://10.0.2.2:8080';

  Future<List<Tag>> fetchAllTags() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/getTags'),
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

  Future<http.Response> createTag(String tagName) async {
    Map<String, String> tagData = {'tagName': tagName};
    return http.post(Uri.parse('$baseUrl/api/addTag'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(tagData));
  }
}
