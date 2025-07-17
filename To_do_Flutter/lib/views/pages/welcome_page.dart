import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:to_do_flutter/views/pages/add_task_page.dart';
import 'package:to_do_flutter/views/widgets/task_card_widget.dart';
import 'package:http/http.dart' as http;

import '../../model/Task.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late Future<List<Task>> futureTasks;

  Future<List<Task>> fetchAllTasks() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/api/getTasks'),
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      List<Task> tasks =
          jsonList.map(((jsonItem) => Task.fromJson(jsonItem as Map<String, dynamic>))).toList();
      return tasks;
    } else {
      throw Exception('Failed to load Tasks');
    }
  }

  @override
  void initState() {
    super.initState();
    futureTasks = fetchAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Witaj w aplikacji ToDo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lime,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return AddTaskPage();
                    },
                  ));
                },
                child: Text('Dodaj zadanie'),
              ),
              FutureBuilder(
                future: futureTasks,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final tasks = snapshot.data!;
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
