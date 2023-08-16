import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:remainder/models/categories.dart';
import 'package:remainder/screens/todo.dart';
import 'package:remainder/stores/app_store.dart';

class CalendarSelectView extends StatelessWidget {
  const CalendarSelectView({super.key});

  @override
  Widget build(BuildContext context) {
    void nav(String id) {
      context.read<AppStore>().getRemaindersForCategory(id);
      context.read<AppStore>().getTodosForCategory(id);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          TaskCategory taskCategory =
              context.read<AppStore>().categories.firstWhere((ele) {
            return ele.id == id;
          });

          return ToDoScreen(taskCategory: taskCategory);
        },
      ));
    }

    return Observer(
      builder: (context) {
        final calWiseViewLoading = context.read<AppStore>().calWiseViewLoading;
        final calShowViewKey = context.read<AppStore>().calShowViewKey;
        if (calWiseViewLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (calShowViewKey == null) {
          return const Center(
            child: Text("All your tasks has been done"),
          );
        }
        final selectDateToView =
            context.read<AppStore>().calendarView[calShowViewKey] ?? [];
        return Column(
          children: selectDateToView.map((e) {
            if (e.isRemainder) {
              return ListTile(
                onTap: () => nav(e.remainder!.categoryId),
                leading: const Icon(Icons.timer),
                title: Text(e.remainder!.task),
              );
            }
            return ListTile(
              onTap: () => nav(e.todo!.categoryId),
              leading: SvgPicture.asset("assets/tasks.svg"),
              title: Text(e.todo!.todo),
            );
          }).toList(),
        );
      },
    );
  }
}
