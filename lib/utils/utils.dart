import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Utils {
  void snackBarMessage(BuildContext context, String message, [double? size]) {
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
}

// static TextStyle titleTextTheme = GoogleFonts.lato(
//   fontSize: 18,
//   fontWeight: FontWeight.bold,
//   color: AppColors.black,
//   // decoration: TextDecoration.underline,
// );

//   static TextStyle titleTextTheme({
//     required BuildContext context,
//     double? size,
//     FontWeight? weight,
//   }) {
//     return GoogleFonts.aBeeZee(
//       fontSize: size ?? 18,
//       fontWeight: weight ?? FontWeight.bold,
//       color: Theme.of(context).colorScheme.primary,
//     );
//   }

//   static TextStyle bodyTextTheme({
//     required BuildContext context,
//     double? size,
//     FontWeight? weight,
//   }) {
//     return GoogleFonts.abel(
//       fontSize: size ?? 15,
//       fontWeight: weight ?? FontWeight.bold,
//       color: Theme.of(context).colorScheme.primary,
//     );
//   }
// }

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
      {super.key, required this.title, this.size, this.weight});
  final String title;
  final double? size;
  final FontWeight? weight;

  @override
  Widget build(BuildContext context) {
    return Text(
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      title,
      style: GoogleFonts.abel(
        fontSize: size ?? 15,
        fontWeight: weight ?? FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

// news.org -> api's key
// apiKey=4f377273fdd74ca7bfbd7ebcaffdc618