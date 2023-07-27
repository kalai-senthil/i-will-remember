import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:remainder/helpers.dart';
import 'package:remainder/models/categories.dart';
import 'package:remainder/stores/app_store.dart';
import 'package:remainder/ui/home_header.dart';
import 'package:remainder/ui/section_header.dart';
import 'package:remainder/ui/page_header.dart';
import 'package:remainder/ui/render_tasks.dart';

class ToDoScreen extends StatelessWidget {
  const ToDoScreen({super.key, required this.taskCategory});
  final TaskCategory taskCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeHeader(),
            PageHeader(
              title: taskCategory.name.padLeft(5),
            ),
            const SizedBox(height: 10),
            SectionHeader(
              title: "Tasks",
              icon: const Icon(Icons.add_box_rounded),
              onPressed: () => createTaskHelper(context: context),
            ),
            Observer(
              builder: (context) {
                final tasksLoading = context.read<AppStore>().tasksLoading;
                if (tasksLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return RenderTasks(
                  id: taskCategory.id,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
