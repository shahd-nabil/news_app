import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../styles/colors.dart';

class SmallText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final int? maxLines;





  const SmallText(this.text, {super.key, this.fontSize, this.color, this.fontWeight, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines:maxLines?? 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.w600,
        color:color?? bodyTextColor,

      ),
    );
  }
}
