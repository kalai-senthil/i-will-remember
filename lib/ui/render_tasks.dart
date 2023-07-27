import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:remainder/stores/app_store.dart';
import 'package:remainder/helpers.dart';
import 'package:remainder/ui/create_categories.dart';
import 'package:remainder/ui/render_task.dart';

class RenderTasks extends StatelessWidget {
  const RenderTasks({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final tasks = context.read<AppStore>().tasks[id] ?? [];
        if (tasks.isEmpty) {
          return CreateData(
            onTap: () => createTaskHelper(context: context),
          );
        }
        return Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return RenderTask(task: tasks.elementAt(index), index: index);
            },
            itemCount: tasks.length,
          ),
        );
      },
    );
  }
}
