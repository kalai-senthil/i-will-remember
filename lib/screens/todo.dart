import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:remainder/helpers.dart';
import 'package:remainder/models/categories.dart';
import 'package:remainder/stores/app_store.dart';
import 'package:remainder/ui/render_todos.dart';
import 'package:remainder/ui/render_remainders.dart';
import 'package:remainder/ui/section_header.dart';
import 'package:remainder/utils.dart';

class ToDoScreen extends HookWidget {
  const ToDoScreen({super.key, required this.taskCategory});
  final TaskCategory taskCategory;
  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 2);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          switch (tabController.index) {
            case 0:
              createTodoHelper(context: context, catId: taskCategory.id);
              break;
            case 1:
              createRemainderHelper(context: context);
              break;
            default:
          }
        },
        child: const Icon(
          Icons.add_rounded,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: Utils.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                icon: const Icon(Icons.refresh_rounded),
                title: taskCategory.name,
                onPressed: () =>
                    context.read<AppStore>().reloadCategory(taskCategory.id),
              ),
              const SizedBox(height: 10),
              TabBar(
                controller: tabController,
                tabs: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/tasks.svg",
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Todos",
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/tasks.svg",
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Remainders",
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    Observer(
                      builder: (context) {
                        final todosLoading =
                            context.read<AppStore>().todosLoading;
                        if (todosLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return RenderTodos(
                          id: taskCategory.id,
                        );
                      },
                    ),
                    Observer(
                      builder: (context) {
                        final remaindersLoading =
                            context.read<AppStore>().remaindersLoading;
                        if (remaindersLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return RenderRemainders(
                          id: taskCategory.id,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
