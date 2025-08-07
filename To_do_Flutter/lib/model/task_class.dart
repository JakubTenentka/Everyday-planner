import 'package:to_do_flutter/model/tag_class.dart';

class Task {
  final int id;
  final String title;
  final DateTime endingDate;
  final List<Tag> tags;
  final bool isDone;

  const Task(
      {required this.title,
      required this.endingDate,
      required this.tags,
      required this.id,
      required this.isDone});

  factory Task.fromJson(Map<String, dynamic> json) {
    List<dynamic> tagsData = json['tags'] as List<dynamic>;

    List<Tag> parsedTags = tagsData.map((tagJson) {
      return Tag.fromJson(tagJson as Map<String, dynamic>);
    }).toList();

    return Task(
      id: json['id'] as int,
      title: json['title'] as String,
      endingDate: DateTime.parse(json['endingDate'] as String),
      isDone: json['isDone'] as bool,
      tags: parsedTags,
    );
  }
}
