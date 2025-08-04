import 'package:flutter/material.dart';

class TagWidget extends StatelessWidget {
  const TagWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Colors.amber[600],
          child: const Center(child: Text('Entry A')),
        ),
      ),
    );
  }
}
