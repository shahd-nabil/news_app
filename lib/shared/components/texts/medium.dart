import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MediumText extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final int? maxLines;


  const MediumText(
      this.text, {
        super.key,
        this.color,
        this.fontWeight,
        this.fontSize,  this.maxLines,
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines?? 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: color ?? Colors.black,

      ),
    );
  }
}

