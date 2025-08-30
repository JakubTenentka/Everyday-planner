import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/task_class.dart';

class TaskService {
  final String baseUrl = 'http://10.0.2.2:8080';

  Future<List<Task>> fetchAllTasks(bool? isDone) async {
    Uri uri;

    if (isDone == null) {
      uri = Uri.parse('$baseUrl/api/getTasks');
    } else {
      uri = Uri.parse('$baseUrl/api/getTasks?isDone=$isDone');
    }

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      List<Task> tasks = jsonList
          .map(((jsonItem) => Task.fromJson(jsonItem as Map<String, dynamic>)))
          .toList();
      return tasks;
    } else if (response.statusCode == 204) {
      return [];
    } else {
      throw Exception('Failed to load Tasks');
    }
  }

  Future<http.Response> createTask(
      String title, DateTime endDate, Set<int> tagIds) {
    String formattedEndDate =
        "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}";
    Map<String, dynamic> taskData = {
      'title': title,
      'endingDate': formattedEndDate,
    };
    String tagParams = tagIds.map((id) => 'tagIds=$id').join('&');
    return http.post(
      Uri.parse('http://10.0.2.2:8080/api/addTask?$tagParams'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(taskData),
    );
  }

  Future<http.Response> markCompletion(int id, bool isDone) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/api/updateTaskStatus/$id?status=$isDone'),
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }

  Future<http.Response> deleteTask(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/api/deleteTask/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }
}
