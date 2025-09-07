import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_flutter/views/pages/add_task_page.dart';
import 'package:to_do_flutter/views/widgets/appbar_widget.dart';
import 'package:to_do_flutter/views/widgets/task_card_widget.dart';
import 'package:to_do_flutter/providers/task_providers.dart';

class WelcomePage extends ConsumerWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notDoneTasksAsyncValue = ref.watch(tasksNotDoneProvider);
    final doneTasksAsyncValue = ref.watch(tasksDoneProvider);

    void handleMarkingTask() {
      ref.refresh(tasksNotDoneProvider);
      ref.refresh(tasksDoneProvider);
    }

    void handleDismissTask(DismissDirection direction, String id) async {
      try {
        await ref.read(taskServiceProvider).deleteTask(int.parse(id));
        ref.refresh(tasksNotDoneProvider);
        ref.refresh(tasksDoneProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usunięto zadanie')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Nie udało się usunąć zadania')),
        );
      }
    }

    return Scaffold(
      appBar: AppbarWidget(title: 'Twoje zadania'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
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
                      // Po dodaniu zadania, odśwież providery
                      ref.refresh(tasksNotDoneProvider);
                      ref.refresh(tasksDoneProvider);
                    }
                  },
                  child: Text('Dodaj zadanie'),
                ),
                notDoneTasksAsyncValue.when(
                  data: (tasks) {
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
                          key: ValueKey<String>(tasks[index].id.toString()),
                          id: tasks[index].id,
                          taskTitle: tasks[index].title,
                          endingDate: tasks[index].endingDate,
                          tags: tasks[index].tags,
                          isDone: tasks[index].isDone,
                          onMarkingTask: handleMarkingTask,
                          ondismissed: handleDismissTask,
                        );
                      }),
                    );
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (err, stack) => Text('Błąd: $err'),
                ),
                ExpansionTile(
                  title: Text('Zrobione'),
                  children: [
                    doneTasksAsyncValue.when(
                      data: (tasks) {
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
                              key: ValueKey(tasks[index].id),
                              id: tasks[index].id,
                              taskTitle: tasks[index].title,
                              endingDate: tasks[index].endingDate,
                              tags: tasks[index].tags,
                              isDone: tasks[index].isDone,
                              onMarkingTask: handleMarkingTask,
                              ondismissed: handleDismissTask,
                            );
                          }),
                        );
                      },
                      loading: () => const CircularProgressIndicator(),
                      error: (err, stack) => Text('Błąd: $err'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
