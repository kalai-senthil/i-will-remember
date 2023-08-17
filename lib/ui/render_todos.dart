import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remainder/helpers.dart';
import 'package:remainder/stores/app_store.dart';
import 'package:remainder/ui/create_categories.dart';
import 'package:remainder/ui/render_todo.dart';

class RenderTodos extends StatelessWidget {
  const RenderTodos({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final tasks = context.read<AppStore>().todos[id] ?? [];
        if (tasks.isEmpty) {
          return CreateData(
            onTap: () => createTodoHelper(context: context, catId: id),
          );
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            return RenderTodo(index: index, categoryId: id);
          },
          itemCount: tasks.length,
        );
      },
    );
  }
}
