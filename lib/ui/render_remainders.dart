import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:remainder/stores/app_store.dart';
import 'package:remainder/helpers.dart';
import 'package:remainder/ui/create_categories.dart';
import 'package:remainder/ui/render_remainder.dart';

class RenderRemainder extends StatelessWidget {
  const RenderRemainder({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final tasks = context.read<AppStore>().remainders[id] ?? [];
        if (tasks.isEmpty) {
          return CreateData(
            onTap: () => createRemainderHelper(context: context),
          );
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            return RenderTask(index: index, categoryId: id);
          },
          itemCount: tasks.length,
        );
      },
    );
  }
}
