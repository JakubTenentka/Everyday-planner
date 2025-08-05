import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:to_do_flutter/views/pages/add_task_page.dart';
import 'package:to_do_flutter/views/widgets/appbar_widget.dart';
import 'package:to_do_flutter/views/widgets/task_card_widget.dart';
import 'package:http/http.dart' as http;

import '../../model/task_class.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late Future<List<Task>> _futureTasks;

  void _refreshTasks() {
    setState(() {
      _futureTasks = fetchAllTasks();
    });
  }

  Future<List<Task>> fetchAllTasks() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/api/getTasks'),
    );
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

  @override
  void initState() {
    super.initState();
    _futureTasks = fetchAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: 'Twoje zadania'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddTaskPage()),
                  );
                  if (result == true) {
                    _refreshTasks();
                  }
                },
                child: Text('Dodaj zadanie'),
              ),
              FutureBuilder(
                future: _futureTasks,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final tasks = snapshot.data!;
                    if (tasks.isEmpty) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          Center(
                            child: Text(
                              'Dodaj swoje pierwsze zadanie!',
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      );
                    }
                    return Column(
                      children: List.generate(tasks.length, (index) {
                        return TaskCardWidget(
                          taskTitle: tasks[index].title,
                          endingDate: tasks[index].endingDate,
                        );
                      }),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
