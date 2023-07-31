import 'package:flutter/material.dart';
import 'package:remainder/ui/hero.dart';
import 'package:remainder/ui/home_header.dart';
import 'package:remainder/ui/calendar_view.dart';
import 'package:remainder/ui/task_categories.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeHeader(),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeHero(),
                  CalendarView(),
                  TaskCategories(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
