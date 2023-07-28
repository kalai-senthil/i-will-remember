import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remainder/bottomsheet.dart';
import 'package:remainder/ui/DaySelector.dart';
import 'package:remainder/ui/InfoShowWithIcon.dart';
import 'package:remainder/stores/app_store.dart';
import 'package:provider/provider.dart';
import 'package:remainder/ui/input.dart';
import 'package:remainder/ui/page_header.dart';
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

void createRemainderHelper({required BuildContext context}) {
  showCustomBottomSheet(
    context: context,
    loading: context.read<AppStore>().addingRemainder,
    onDone: () {
      Navigator.of(context).pop();
    },
    widget: Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 20),
        child: Observer(builder: (context) {
          final addingTask = context.read<AppStore>().addingRemainder;
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
    return SingleChildScrollView(
      child: Column(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoShowWithIcon(
                  icon: const Icon(
                    Icons.task_outlined,
                    color: Utils.primaryColor,
                  ),
                  info: "Task",
                  child: InputWidget(
                    autoFocus: false,
                    hintText: "Type Task",
                    onChange: context.read<AppStore>().setAddTaskText,
                    isDense: true,
                  ),
                ),
                InfoShowWithIcon(
                  icon: const Icon(
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
                        hint: Text(
                          "Select",
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                          ),
                        ),
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
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                      child: InfoShowWithIcon(
                        icon: const Icon(
                          Icons.calendar_today_outlined,
                          color: Utils.primaryColor,
                        ),
                        info: "Date",
                        child: Observer(builder: (context) {
                          final addTaskDateAndTime =
                              context.read<AppStore>().addRemainderDateAndTime;
                          return InkWell(
                            onTap: () {
                              context
                                  .read<AppStore>()
                                  .setAddRemainderDate(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  formatDate(
                                    addTaskDateAndTime,
                                    [
                                      M,
                                      ', ',
                                      d,
                                    ],
                                  ),
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_drop_down_rounded,
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                    Flexible(
                      child: InfoShowWithIcon(
                        icon: const Icon(
                          Icons.timelapse_rounded,
                          color: Utils.primaryColor,
                        ),
                        info: "Time",
                        child: Observer(builder: (context) {
                          final addTaskTime =
                              context.read<AppStore>().addRemainderDateAndTime;
                          return InkWell(
                            onTap: () {
                              context
                                  .read<AppStore>()
                                  .setAddRemainderTime(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  formatDate(
                                    addTaskTime,
                                    [
                                      h,
                                      ':',
                                      ss,
                                      ' ',
                                      am,
                                    ],
                                  ),
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_drop_down_rounded,
                                )
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: PageHeader(
                    title: "Days",
                  ),
                ),
                const DaySelector(),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Observer(builder: (context) {
                      final addingTask =
                          context.read<AppStore>().addingRemainder;
                      return Expanded(
                        child: TextButton.icon(
                          onPressed: () async {
                            if (!addingTask) {
                              final isSuccess =
                                  await context.read<AppStore>().addTask();
                              if (isSuccess) {
                                (() => {Navigator.of(context).pop()})();
                              }
                            }
                          },
                          style: const ButtonStyle(
                            alignment: Alignment.center,
                          ),
                          icon: addingTask
                              ? const CircularProgressIndicator.adaptive()
                              : const Icon(Icons.done_rounded),
                          label: const Text(
                            "Save Changes",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
