import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:remainder/stores/app_store.dart';

class RenderRemainder extends HookWidget {
  const RenderRemainder(
      {super.key, required this.index, required this.categoryId});
  final int index;
  final String categoryId;
  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    return Observer(builder: (context) {
      final task =
          (context.read<AppStore>().remainders[categoryId] ?? [])[index];
      return ListTile(
        trailing: ValueListenableBuilder(
          valueListenable: loading,
          builder: (context, value, w) {
            if (value) {
              return const CircularProgressIndicator();
            }
            return Switch(
              value: task.enabled,
              onChanged: (e) async {
                loading.value = true;
                final res = await context.read<AppStore>().toggleRemiander(
                      categoryId,
                      task.id,
                      index,
                      e,
                    );
                if (res) {}
                loading.value = false;
              },
            );
          },
        ),
        subtitle: Text(
          formatDate(
            task.createdAt,
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
          task.task,
          style: GoogleFonts.quicksand(),
        ),
      );
    });
  }
}
