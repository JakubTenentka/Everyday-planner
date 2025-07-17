class Task {
  final String title;
  final DateTime endingDate;

  const Task({required this.title, required this.endingDate});

  factory Task.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'title': String title, 'endingDate': String endingDateStr} => Task(
          title: title,
          endingDate: DateTime.parse(endingDateStr),
        ),
      _ => throw const FormatException('Failed to load Tasks')
    };
  }
}
