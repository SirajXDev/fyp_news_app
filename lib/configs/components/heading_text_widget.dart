import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_application_2/configs/color/color.dart';

class HeadingTextWidget extends StatelessWidget {
  const HeadingTextWidget({
    super.key,
    required this.headingText,
    this.size,
    this.style,
    this.weight,
    this.color,
  });

  final String headingText;
  final double? size;
  final FontStyle? style;
  final FontWeight? weight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      headingText,
      style: GoogleFonts.cabin(
        fontSize: size ?? 25.0,
        fontWeight: weight ?? FontWeight.bold,
        fontStyle: style ?? FontStyle.normal,
        color: color ?? AppColors.black,
      ),
    );
  }
}
