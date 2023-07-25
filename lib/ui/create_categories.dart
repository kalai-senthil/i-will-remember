import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:remainder/bottomsheet.dart';
import 'package:remainder/stores/app_store.dart';
import 'package:remainder/ui/create_category_modal.dart';
import 'package:remainder/ui/section_header.dart';
import 'package:remainder/utils.dart';

import 'input.dart';

class CreateCategory extends StatelessWidget {
  const CreateCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showCustomAlertDialog(
          context: context,
          loading: context.read<AppStore>().addCategoryLoading,
          onDone: () {
            context.read<AppStore>().addCategoryToDB();
            Navigator.of(context).pop();
          },
          widget: Observer(builder: (context) {
            final addCategoryLoading =
                context.read<AppStore>().addCategoryLoading;
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
      },
      child: Container(
        padding:
            Utils.cardPadding.add(const EdgeInsets.symmetric(vertical: 20)),
        decoration: BoxDecoration(
          borderRadius: Utils.borderRadiusRoundedCard,
          border: Border.all(
            color: Utils.lightPrimaryColor,
          ),
        ),
        child: const Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.add,
                      size: 40,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Add",
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
