class Item {
  String name;
  bool isChecked;
  int count;

  Item({
    required this.name,
    this.isChecked = false,
    this.count = 1,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'] as String,
      isChecked: json['checked'] as bool? ?? false,
      count: json['count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isChecked': isChecked,
      'count': count,
    };
  }
}
