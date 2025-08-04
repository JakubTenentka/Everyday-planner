import 'dart:ffi';

class Tag {
  final Long id;
  final String tagName;

  const Tag({required this.id, required this.tagName});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': Long id, 'tagName': String tagName} => Tag(
          id: id,
          tagName: tagName,
        ),
      _ => throw const FormatException('Failed to load Tags')
    };
  }
}
