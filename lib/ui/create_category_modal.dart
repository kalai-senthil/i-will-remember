import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:remainder/ui/input.dart';
import 'package:remainder/ui/section_header.dart';

class CreateCategoryModal extends StatelessWidget {
  const CreateCategoryModal({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SectionHeader(title: "Add Category"),
          InputWidget(
            hintText: "Type...",
            onChange: (e) {},
          ),
        ],
      ),
    );
  }
}
