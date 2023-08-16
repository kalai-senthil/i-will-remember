import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:remainder/stores/app_store.dart';
import 'package:remainder/helpers.dart';
import 'package:remainder/ui/create_categories.dart';
import 'package:remainder/ui/render_remainder.dart';

class RenderRemainders extends StatelessWidget {
  const RenderRemainders({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final tasks = context.watch<AppStore>().remainders[id] ?? [];
        if (tasks.isEmpty) {
          return CreateData(
            onTap: () => createRemainderHelper(context: context),
          );
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            return RenderRemainder(index: index, categoryId: id);
          },
          itemCount: tasks.length,
        );
      },
    );
  }
}
