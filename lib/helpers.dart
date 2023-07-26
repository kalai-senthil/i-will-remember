import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remainder/bottomsheet.dart';
import 'package:remainder/ui/InfoShowWithIcon.dart';
import 'package:remainder/stores/app_store.dart';
import 'package:provider/provider.dart';
import 'package:remainder/ui/input.dart';
import 'package:remainder/ui/section_header.dart';
import 'package:remainder/utils.dart';

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
          return NewWidget(addingTask: addingTask);
        }),
      ),
    ),
  );
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required this.addingTask,
  });

  final bool addingTask;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Stack(
          alignment: Alignment.topLeft,
          children: [
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
            const Row(
              children: [
                Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 20,
                ),
                SizedBox(width: 5),
                Text("Back"),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              InfoShowWithIcon(
                icon: Icon(
                  Icons.interests_outlined,
                  color: Utils.primaryColor,
                ),
                info: "Categories",
                child: Observer(
                  builder: (context) {
                    final categories = context.read<AppStore>().categories;
                    final selectedCategory =
                        context.read<AppStore>().selectedCategory;
                    return DropdownButton(
                      isExpanded: true,
                      isDense: true,
                      style: GoogleFonts.quicksand(
                        color: Colors.black,
                      ),
                      value: selectedCategory,
                      icon: const Icon(Icons.arrow_drop_down_rounded),
                      onChanged: context.read<AppStore>().setSelectedCategory,
                      items: categories
                          .map(
                            (e) => DropdownMenuItem(
                              value: e.id,
                              child: Text(
                                e.name,
                                style: GoogleFonts.quicksand(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
