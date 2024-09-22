import 'package:share_it/share_it.dart';

class ShareHelper {
  static Future<void> shareLink({required String url, String? title}) async {
    ShareIt.link(
        url: url, androidSheetTitle: title ?? 'share news with your friends');
  }
}
