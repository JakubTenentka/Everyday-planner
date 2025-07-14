import 'package:flutter/material.dart';
import 'package:to_do_flutter/model/Task.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TextEditingController nameFieldController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<http.Response> createTask(String title, DateTime endDate) {
    String formattedEndDate =
        "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}";
    Map<String, dynamic> taskData = {
      'title': title,
      'endDate': formattedEndDate,
    };

    return http.post(
      Uri.parse('localhost:8080/api/addTask'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(taskData),
    );
  }

  @override
  void dispose() {
    nameFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dodaj zadanie'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Nazwa',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilledButton(
                      onPressed: () async {
                        final DateTime? dateTime = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(3000),
                        );
                        if (dateTime != null) {
                          setState(() {
                            selectedDate = dateTime;
                          });
                        }
                      },
                      child: const Text('Wybierz termin zadania')),
                  Text(
                    "${selectedDate.year} - ${selectedDate.month} - ${selectedDate.day}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    Task task = Task(nameFieldController.text, selectedDate);
                  },
                  child: Text('Dodaj zadanie'))
            ],
          ),
        ),
      ),
    );
  }
}
