import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  double size;
  final String text;
  final Color color;

  AppText(
      {super.key,
      this.size = 25,
      required this.text, //must be included in the parameter
      this.color = const Color.fromARGB(255, 248, 248, 248)});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.workSans(
        //setting properties for the bold text
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
