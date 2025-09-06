import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:to_do_flutter/model/item_class.dart';

class ItemService {
  final String baseUrl = 'http://10.0.2.2:8080';

  // W ItemService
  Future<List<Item>> fetchAllItems() async {
    try {
      final response =
          await http.get(Uri.parse("$baseUrl/api/shopping/getItems"));
      print('Status odpowiedzi z backendu: ${response.statusCode}');

      print('Surowe ciało odpowiedzi JSON: ${response.body}');
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<Item> items =
            body.map((dynamic itemJson) => Item.fromJson(itemJson)).toList();
        print('Pomyślnie zdeserializowano ${items.length} itemów');
        return items;
      } else {
        print('Błąd backendu: ${response.statusCode}');
        return []; // Zwróć pustą listę w przypadku błędu serwera
      }
    } catch (e) {
      print('Wyjątek w fetchAllItems: $e');
      return []; // Zwróć pustą listę w przypadku wyjątku
    }
  }
}
