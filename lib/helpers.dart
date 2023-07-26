import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remainder/bottomsheet.dart';
import 'package:remainder/stores/app_store.dart';
import 'package:provider/provider.dart';
import 'package:remainder/ui/input.dart';
import 'package:remainder/ui/section_header.dart';

void createCategoryHelper({required BuildContext context}) {
  showCustomAlertDialog(
    context: context,
    loading: context.read<AppStore>().addCategoryLoading,
    onDone: () {
      context.read<AppStore>().addCategoryToDB();
      Navigator.of(context).pop();
    },
    widget: Observer(builder: (context) {
      final addCategoryLoading = context.read<AppStore>().addCategoryLoading;
      return SingleChildScrollView(
        child: Column(
          children: [
            const SectionHeader(title: "Add Category"),
            InputWidget(
              disabled: addCategoryLoading,
              hintText: "Type...",
              onChange: context.read<AppStore>().setAddCategoryText,
            ),
          ],
        ),
      );
    }),
  );
}

void createTaskHelper({required BuildContext context}) {
  showCustomBottomSheet(
    context: context,
    loading: context.read<AppStore>().addingTask,
    onDone: () {
      Navigator.of(context).pop();
    },
    widget: Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 20),
        child: Observer(builder: (context) {
          final addingTask = context.read<AppStore>().addingTask;
          return Column(
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 15,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Back",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 250,
                    child: Image.asset(
                      "assets/addTask.png",
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                      height: 800,
                      width: 1800,
                    ),
                  ),
                ],
              ),
              InputWidget(
                disabled: addingTask,
                hintText: "Type...",
                onChange: context.read<AppStore>().setAddCategoryText,
              ),
            ],
          );
        }),
      ),
    ),
  );
}
