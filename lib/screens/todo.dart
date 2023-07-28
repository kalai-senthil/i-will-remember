import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:remainder/helpers.dart';
import 'package:remainder/models/categories.dart';
import 'package:remainder/stores/app_store.dart';
import 'package:remainder/ui/home_header.dart';
import 'package:remainder/ui/section_header.dart';
import 'package:remainder/ui/page_header.dart';
import 'package:remainder/ui/render_remainders.dart';
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
              PageHeader(
                title: taskCategory.name,
              ),
              const SizedBox(height: 10),
              TabBar(
                controller: tabController,
                tabs: [
                  SvgPicture.asset(
                    "assets/tasks.svg",
                  ),
                  SvgPicture.asset(
                    "assets/tasks.svg",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    Observer(
                      builder: (context) {
                        final remaindersLoading =
                            context.read<AppStore>().remaindersLoading;
                        if (remaindersLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return RenderRemainder(
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
                        return RenderRemainder(
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
