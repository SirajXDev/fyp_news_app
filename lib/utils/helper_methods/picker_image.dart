import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ObtainImg {
  static Future<XFile?> obtainImage(
      ImagePicker picker, ImageSource source) async {
    try {
      final file = await picker.pickImage(source: source);
      debugPrint('obtainImage: ${file?.path}');
      return file;
    } catch (e) {
      debugPrint('obtainImage error: $e');
      throw Exception(e);
    }
  }
}
