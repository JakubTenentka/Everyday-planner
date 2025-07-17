import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateFormat dateFormat = DateFormat("yyyy-MM-dd");

class TaskCardWidget extends StatefulWidget {
  const TaskCardWidget({super.key, required this.taskTitle, required this.endingDate});

  final String taskTitle;
  final String endingDate;

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
                        fontSize: 16.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(widget.endingDate),
                ],
              ),
              Checkbox(
                value: isTaskchecked,
                onChanged: (bool? value) {
                  setState(() {
                    isTaskchecked = value;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
