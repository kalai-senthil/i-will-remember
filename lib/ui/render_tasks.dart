import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:remainder/stores/app_store.dart';
import 'package:remainder/helpers.dart';
import 'package:remainder/ui/create_categories.dart';
import 'package:remainder/ui/section_header.dart';

class RenderTasks extends StatelessWidget {
  const RenderTasks({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const SectionHeader(title: "Tasks"),
        Observer(
          builder: (context) {
            final tasks = context.read<AppStore>().tasks[id] ?? [];
            if (tasks.isEmpty) {
              return CreateData(
                onTap: () => createTaskHelper(context: context),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return Text(tasks[index].task);
              },
              itemCount: tasks.length,
            );
          },
        ),
      ],
    );
  }
}
