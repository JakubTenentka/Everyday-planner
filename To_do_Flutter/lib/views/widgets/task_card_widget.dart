import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:to_do_flutter/model/tag_class.dart';
import 'package:to_do_flutter/services/task_service.dart';

class TaskCardWidget extends StatefulWidget {
  const TaskCardWidget({
    super.key,
    required this.id,
    required this.taskTitle,
    required this.endingDate,
    required this.tags,
    required this.isDone,
    required this.onMarkingTask,
    required this.ondismissed,
  });

  final String taskTitle;
  final DateTime endingDate;
  final List<Tag> tags;
  final int id;
  final bool isDone;
  final VoidCallback onMarkingTask;
  final Function(DismissDirection, String) ondismissed;

  @override
  State<TaskCardWidget> createState() => _TaskCardWidgetState();
}

class _TaskCardWidgetState extends State<TaskCardWidget> {
  TaskService taskService = TaskService();
  late bool? isTaskchecked = widget.isDone;

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic);
    if (isTaskchecked == true) {
      titleStyle = titleStyle.copyWith(
        decoration: TextDecoration.lineThrough,
        decorationThickness: 2.5,
        decorationColor: Theme.of(context).colorScheme.surface,
      );
    }

    return Dismissible(
      // TODO Miga jakiś błąd bezpośrednio po usunięciu zadania
      key: ValueKey<String>(widget.id.toString()),
      background: Container(
        color: Color.fromARGB(255, 144, 79, 94),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        widget.ondismissed(direction, widget.id.toString());
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 15.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.taskTitle,
                      style: titleStyle,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(DateFormat('yyyy-MM-dd').format(widget.endingDate)),
                    SizedBox(
                      height: 10.0,
                    ),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: widget.tags.map((tag) {
                        return Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: ShapeDecoration(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            shape: StadiumBorder(
                                side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            )),
                          ),
                          child: Text(
                            tag.tagName,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                Checkbox(
                    value: isTaskchecked,
                    onChanged: (bool? value) async {
                      if (value != null) {
                        setState(() {
                          isTaskchecked = value;
                        });
                        try {
                          final http.Response response = await taskService
                              .markCompletion(widget.id, value);

                          if (response.statusCode == 204) {
                            widget.onMarkingTask();
                          } else {
                            setState(() {
                              isTaskchecked = !value;
                            });
                          }
                        } catch (e) {
                          setState(() {
                            isTaskchecked = !value;
                          });
                        }
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
