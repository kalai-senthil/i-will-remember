import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:remainder/models/categories.dart';
import 'package:remainder/stores/app_store.dart';
import 'package:remainder/ui/home_header.dart';
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
          children: [
            const HomeHeader(),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PageHeader(
                      title: taskCategory.name,
                    ),
                    Observer(
                      builder: (context) {
                        final tasksLoading =
                            context.read<AppStore>().tasksLoading;
                        if (tasksLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return RenderTasks(
                          id: taskCategory.id,
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
