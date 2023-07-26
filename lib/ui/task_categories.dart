import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:remainder/helpers.dart';
import 'package:remainder/stores/app_store.dart';
import 'package:remainder/ui/Render_Category.dart';
import 'package:remainder/ui/create_categories.dart';
import 'package:remainder/ui/section_header.dart';
import 'package:remainder/utils.dart';

class TaskCategories extends StatelessWidget {
  const TaskCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(
          title: "Categories",
          icon: const Icon(
            Icons.add_box_rounded,
            color: Utils.darkPrimaryColor,
          ),
          onPressed: () {
            createCategoryHelper(context: context);
          },
        ),
        Observer(
          builder: (context) {
            final categories = context.read<AppStore>().categories;
            if (categories.isEmpty) {
              return CreateData(
                onTap: () => createCategoryHelper(context: context),
              );
            }
            return ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 170),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return RenderCategory(category: categories.elementAt(index));
                },
                itemCount: categories.length,
              ),
            );
          },
        )
      ],
    );
  }
}
