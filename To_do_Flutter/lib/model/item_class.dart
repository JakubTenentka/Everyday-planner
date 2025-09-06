class Item {
  String name;
  bool isChecked;
  int count = 0;
  bool isEditing;

  Item(
      {required this.name,
      this.isChecked = false,
      this.count = 1,
      this.isEditing = false});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'] as String,
      isChecked: json['checked'] as bool,
      count: json['count'] as int,
    );
  }
}
