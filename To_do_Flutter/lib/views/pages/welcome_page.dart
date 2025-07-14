import 'package:flutter/material.dart';
import 'package:to_do_flutter/views/pages/add_task_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

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
                  child: Text('Dodaj zadanie'))
            ],
          ),
        ),
      ),
    );
  }
}
