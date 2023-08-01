import 'package:flutter/material.dart';
import 'package:remainder/ui/calendar_view.dart';
import 'package:remainder/ui/section_header.dart';

import 'cal_select_view.dart';

class HomwView extends StatelessWidget {
  const HomwView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CalendarView(),
        SectionHeader(title: "You Have"),
        CalendarSelectView(),
      ],
    );
  }
}
