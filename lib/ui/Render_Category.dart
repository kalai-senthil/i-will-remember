import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:remainder/models/categories.dart';
import 'package:remainder/screens/todo.dart';
import 'package:remainder/stores/app_store.dart';
import 'package:remainder/utils.dart';

class RenderCategory extends StatelessWidget {
  const RenderCategory({super.key, required this.category});
  final TaskCategory category;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        top: 20,
        bottom: 8,
      ),
      decoration: BoxDecoration(
        color: Utils.lightPrimaryColor,
        borderRadius: Utils.borderRadiusRoundedCard * 1.5,
      ),
      width: 125,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/img.png"),
          Text(
            category.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w800,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  context
                      .read<AppStore>()
                      .getRemaindersForCategory(category.id);
                  context.read<AppStore>().getTodosForCategory(category.id);
                  return ToDoScreen(
                    taskCategory: category,
                  );
                },
              ));
            },
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      boxShadow: Utils.cardBtnShadow,
                      color: Colors.white,
                      borderRadius: Utils.borderRadiusRoundedCard,
                    ),
                    child: Center(
                      child: Text(
                        "View",
                        style: GoogleFonts.quicksand(
                          color: Utils.darkPrimaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
