import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_flutter/services/task_service.dart';

import '../model/task_class.dart';

//Dostawca dla taskService
final taskServiceProvider = Provider<TaskService>((ref) {
  return TaskService();
});

//Dostawca dla niezakończonych zadań
final tasksNotDoneProvider = FutureProvider<List<Task>>((ref) async {
  final taskService = ref.watch(taskServiceProvider);
  return taskService.fetchAllTasks(false);
});

//Dostawca dla zakończonych zadań
final tasksDoneProvider = FutureProvider<List<Task>>((ref) async {
  final taskService = ref.watch(taskServiceProvider);
  return taskService.fetchAllTasks(true);
});
