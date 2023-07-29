import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:remainder/helpers.dart';
import 'package:remainder/stores/app_store.dart';
import 'package:remainder/utils.dart';

class RenderTodo extends HookWidget {
  const RenderTodo({super.key, required this.categoryId, required this.index});
  final String categoryId;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Utils.lightPrimaryColor,
            width: 2,
          ),
        ),
      ),
      child: Observer(
        builder: (context) {
          final todo =
              (context.read<AppStore>().todos[categoryId] ?? [])[index];
          return ListTile(
            leading: todo.completed
                ? const Icon(
                    Icons.check_circle_outlined,
                  )
                : const Icon(Icons.close_rounded),
            trailing: IconButton(
              onPressed: () {
                createTodoEditHelper(
                  context: context,
                  todo: todo,
                );
              },
              icon: const Icon(
                Icons.edit_note_rounded,
              ),
            ),
            subtitle: Text(
              formatDate(
                todo.createdAt,
                [
                  hh,
                  ":",
                  nn,
                  " ",
                  am,
                ],
              ),
            ),
            title: Text(
              todo.todo,
              style: GoogleFonts.quicksand(
                decoration: todo.completed
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          );
        },
      ),
    );
  }
}
