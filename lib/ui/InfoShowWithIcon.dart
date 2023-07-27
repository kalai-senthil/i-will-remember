import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remainder/utils.dart';

class InfoShowWithIcon extends StatelessWidget {
  const InfoShowWithIcon(
      {super.key, required this.child, required this.icon, required this.info});
  final Widget child;
  final Widget icon;
  final String info;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: Utils.borderRadiusRoundedCard * 2,
        border: Border.all(
          color: Utils.lightPrimaryColor,
          width: 2,
        ),
      ),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Flexible(
            child: icon,
          ),
          const SizedBox(width: 15),
          Container(
            width: 2,
            height: 25,
            decoration: BoxDecoration(
              borderRadius: Utils.borderRadiusRoundedFull,
              color: Utils.lightPrimaryColor,
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  info,
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    color: Utils.primaryColor,
                  ),
                ),
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
