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
    } catch (e) {
      if (kDebugMode) {
        print('Error launching URL: $e');
      }
    }
  }
} // class end

class TitleTextThemeWidget extends StatelessWidget {
  const TitleTextThemeWidget(
      {super.key, required this.title, this.size, this.weight});
  final String title;
  final double? size;
  final FontWeight? weight;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 3,
      style: GoogleFonts.aBeeZee(
        fontSize: size ?? 18,
        fontWeight: weight ?? FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
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
      this.shrinkWrap = true});
  final String title;
  final double? size;
  final FontWeight? weight;
  final TextOverflow? overflow;
  final bool? shrinkWrap;

  @override
  Widget build(BuildContext context) {
    return Text(
      softWrap: shrinkWrap,
      overflow: overflow ?? TextOverflow.ellipsis,
      title,
      style: GoogleFonts.abel(
        fontSize: size ?? 15,
        fontWeight: weight ?? FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
