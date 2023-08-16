import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader(
      {super.key, required this.title, this.onPressed, this.icon});
  final String title;
  final Widget? icon;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ),
        if (icon != null) IconButton(onPressed: onPressed, icon: icon!)
      ],
    );
  }
}
