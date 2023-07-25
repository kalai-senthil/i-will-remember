import 'package:flutter/widgets.dart';
import 'package:remainder/models/categories.dart';

class RenderCategory extends StatelessWidget {
  const RenderCategory({super.key, required this.category});
  final TaskCategory category;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          category.name,
        )
      ],
    );
  }
}
