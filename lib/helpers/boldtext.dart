import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BoldText extends StatelessWidget {
  double size;
  final String text;
  final Color color;
  BoldText(
      //constructor for the function to take
      {super.key,
      this.size = 30,
      required this.text, //must be included in the parameter
      this.color = Colors.white});

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
