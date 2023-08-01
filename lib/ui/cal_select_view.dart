import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:remainder/stores/app_store.dart';

class CalendarSelectView extends StatelessWidget {
  const CalendarSelectView({super.key});

  @override
  Widget build(BuildContext context) {
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
                title: Text(e.remainder!.task),
              );
            }
            return ListTile(
              title: Text(e.todo!.todo),
            );
          }).toList(),
        );
      },
    );
  }
}
