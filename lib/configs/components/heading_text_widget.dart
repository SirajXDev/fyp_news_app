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
    this.textAlign,
  });

  final String headingText;
  final double? size;
  final FontStyle? style;
  final FontWeight? weight;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      headingText,
      textAlign: textAlign,
      style: GoogleFonts.cabin(
        fontSize: size ?? 25.0,
        fontWeight: weight ?? FontWeight.bold,
        fontStyle: style ?? FontStyle.normal,
        color: color ?? Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
