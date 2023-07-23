import 'package:flutter/material.dart';
import 'package:remainder/ui/section_header.dart';

class TaskCategories extends StatelessWidget {
  const TaskCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SectionHeader(
          title: "Categories",
        ),
      ],
    );
  }
}
