import 'package:flutter/material.dart';
import 'package:to_do_flutter/services/task_service.dart';
import 'package:to_do_flutter/views/pages/add_task_page.dart';
import 'package:to_do_flutter/views/widgets/appbar_widget.dart';
import 'package:to_do_flutter/views/widgets/task_card_widget.dart';
import '../../model/task_class.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late Future<List<Task>> _futureNotDoneTasks;
  late Future<List<Task>> _futureDoneTasks;
  TaskService taskService = TaskService();

  void _refreshTasks() {
    setState(() {
      _futureNotDoneTasks = taskService.fetchAllTasks(false);
      _futureDoneTasks = taskService.fetchAllTasks(true);
    });
  }

  @override
  void initState() {
    super.initState();
    _futureNotDoneTasks = taskService.fetchAllTasks(false);
    _futureDoneTasks = taskService.fetchAllTasks(true);
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
              SingleChildScrollView(
                child: FutureBuilder(
                  future: _futureNotDoneTasks,
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
                            tags: tasks[index].tags,
                          );
                        }),
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
              ExpansionTile(title: Text('Zrobione'), children: [
                FutureBuilder(
                  future: _futureDoneTasks,
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
                                'Brak ukończonych zadań',
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
                            tags: tasks[index].tags,
                          );
                        }),
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
