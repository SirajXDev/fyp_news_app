import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static void snackBarMessage(BuildContext context, String message,
      [double? size]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(fontSize: size ?? 20, color: Colors.white),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  static const spinKit2 = SpinKitFadingCircle(
    color: Colors.amber,
    size: 50,
  );
  static final dateFormat = DateFormat('MMMM dd, yyyy');
  // web url launcher

  void launcherUrl(String url) {
    try {
      launchUrl(Uri.parse('https:$url'));
      debugPrint('imagURL: $url');
    } catch (e) {
      if (kDebugMode) {
        print('Error launching URL: $e');
      }
    }
  }

  static InputDecoration commonDecoration({
    required String hint,
    required BuildContext context,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      hintStyle: TextStyle(
        color: Theme.of(context).colorScheme.surface,
        fontSize: 12,
      ),
      fillColor: Theme.of(context).colorScheme.outline,
      contentPadding:
          const EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      suffixIcon: suffixIcon,
    );
  }
} // class end

class TitleTextThemeWidget extends StatelessWidget {
  const TitleTextThemeWidget(
      {super.key,
      required this.title,
      this.size,
      this.weight,
      this.color,
      this.textAlign});
  final String title;
  final double? size;
  final FontWeight? weight;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 3,
      textAlign: textAlign,
      style: GoogleFonts.aBeeZee(
        fontSize: size ?? 18,
        fontWeight: weight ?? FontWeight.bold,
        color: color ?? Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class BodyTextThemeWidget extends StatelessWidget {
  const BodyTextThemeWidget(
      {super.key,
      required this.title,
      this.size,
      this.weight,
      this.overflow = TextOverflow.visible,
      this.shrinkWrap = true,
      this.textAlign,
      this.maxLines,
      this.color});
  final String title;
  final double? size;
  final FontWeight? weight;
  final TextOverflow? overflow;
  final bool? shrinkWrap;
  final TextAlign? textAlign;
  final int? maxLines;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign,
      softWrap: shrinkWrap,
      overflow: overflow ?? TextOverflow.ellipsis,
      maxLines: maxLines,
      title,
      style: GoogleFonts.abel(
        fontSize: size ?? 15,
        fontWeight: weight ?? FontWeight.bold,
        color: color ?? Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
