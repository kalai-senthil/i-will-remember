import 'package:flutter/material.dart';
import 'package:remainder/utils.dart';

class CreateData extends StatelessWidget {
  const CreateData({super.key, required this.onTap});
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
