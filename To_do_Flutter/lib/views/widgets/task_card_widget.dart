import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_flutter/model/tag_class.dart';

class TaskCardWidget extends StatefulWidget {
  const TaskCardWidget(
      {super.key,
      required this.taskTitle,
      required this.endingDate,
      required this.tags});

  final String taskTitle;
  final DateTime endingDate;
  final List<Tag> tags;

  @override
  State<TaskCardWidget> createState() => _TaskCardWidgetState();
}

class _TaskCardWidgetState extends State<TaskCardWidget> {
  bool? isTaskchecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
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
                          color: Colors.grey,
                          shape: StadiumBorder(),
                        ),
                        child: Text(
                          tag.tagName,
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Checkbox(
                value: isTaskchecked,
                onChanged: (bool? value) {
                  setState(() {
                    isTaskchecked = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
