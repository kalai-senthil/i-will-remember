import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.quicksand(
        fontWeight: FontWeight.w800,
        fontSize: 25,
      ),
    );
  }
}
