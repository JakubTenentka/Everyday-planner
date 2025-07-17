import 'package:flutter/material.dart';
import 'package:to_do_flutter/views/pages/add_task_page.dart';
import 'package:to_do_flutter/views/widgets/task_card_widget.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
              TaskCardWidget(taskTitle: 'Testowy tytuł', endingDate: '2025-05-05'),
              TaskCardWidget(taskTitle: 'Testowy tytuł', endingDate: '2025-05-05'),
            ],
          ),
        ),
      ),
    );
  }
}
