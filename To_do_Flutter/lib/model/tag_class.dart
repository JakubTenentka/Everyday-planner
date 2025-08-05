class Tag {
  final int id;
  final String tagName;

  const Tag({required this.id, required this.tagName});

  factory Tag.fromJson(Map<String, dynamic> json) {
    try {
      return Tag(
        id: json['id'] as int,
        tagName: json['tagName'] as String,
      );
    } catch (_) {
      throw const FormatException('Failed to load Tags');
    }
  }
}
