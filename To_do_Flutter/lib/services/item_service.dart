import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:to_do_flutter/model/item_class.dart';

class ItemService {
  final String baseUrl = 'http://10.0.2.2:8080';

  Future<List<Item>> fetchAllItems() async {
    try {
      final response =
          await http.get(Uri.parse("$baseUrl/api/shopping/getItems"));

      if (response.statusCode == 200) {
        print("Response body: ${response.body}");
        List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic itemJson) => Item.fromJson(itemJson)).toList();
      } else {
        print("Błąd backendu: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print('Wyjątek w fetchAllItems: $e');
      return [];
    }
  }

  Future<Item> addItem(Item newItemData) async {
    final response = await http.post(Uri.parse("$baseUrl/api/shopping/addItem"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(newItemData));
    if (response.statusCode == 201) {
      return Item.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add item');
    }
  }
}
