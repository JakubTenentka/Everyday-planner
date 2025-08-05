import 'package:flutter/material.dart';

class TagWidget extends StatelessWidget {
  const TagWidget({super.key, required this.id, required this.tagName});

  final int id;
  final String tagName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Colors.amber[600],
          child: Center(child: Text(tagName)),
        ),
      ),
    );
  }
}
