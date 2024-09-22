 import 'package:flutter/material.dart';
 import 'package:share_it/share_it.dart';

 class ShareHelper {
   /// Shares text and url

   static Future<void> shareLink({
     required String url,
    required String? title,
  }) async {
     try {
       await ShareIt.link(
         url: url,
         androidSheetTitle: title,
       );
     } catch (e) {
       debugPrint('Error sharing link: $e');
     }
  }
 }

