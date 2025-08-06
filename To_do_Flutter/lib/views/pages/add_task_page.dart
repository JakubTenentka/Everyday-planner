import 'package:flutter/material.dart';
import 'package:to_do_flutter/services/tag_service.dart';
import 'package:to_do_flutter/services/task_service.dart';
import '../../model/tag_class.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TextEditingController nameFieldController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TaskService taskService = TaskService();
  TagService tagService = TagService();
  late Future<List<Tag>> _tagsFuture;
  Set<int> selectedTagIds = {};

  @override
  void dispose() {
    nameFieldController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tagsFuture = tagService.fetchAllTags();
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
                controller: nameFieldController,
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
              FutureBuilder(
                  future: _tagsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Błąd ładowania tagów: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final List<Tag> tags = snapshot.data!;
                      if (tags.isEmpty) {
                        return Text('Brak dostępnych tagów.');
                      }
                      return Wrap(
                        spacing: 5.0,
                        children: tags.map((Tag tag) {
                          return FilterChip(
                            label: Text(tag.tagName),
                            selected: selectedTagIds.contains(tag.id),
                            onSelected: (bool selected) {
                              setState(() {
                                if (selected) {
                                  selectedTagIds.add(tag.id);
                                } else {
                                  selectedTagIds.remove(tag.id);
                                }
                              });
                            },
                          );
                        }).toList(),
                      );
                    } else {
                      return Text('Brak tagów');
                    }
                  }),
              ElevatedButton(
                onPressed: () async {
                  //TODO Naprawić niedodawanie tasków które nie mają tagu!!
                  await taskService.createTask(
                      nameFieldController.text, selectedDate, selectedTagIds);
                  Navigator.pop(context, true);
                },
                child: Text('Dodaj zadanie'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
