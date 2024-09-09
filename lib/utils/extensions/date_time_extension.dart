import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String timeAgo() {
    final format = DateFormat('MMMM dd, yyyy');
    final duration = DateTime.now().difference(this);
    if (duration.inMinutes < 0) {
      return format.format(this);
    } else if (duration.inMinutes < 60) {
      return '${duration.inMinutes}m ago';
    } else if (duration.inHours < 24) {
      return '${duration.inHours}h ago';
    } else {
      return '${duration.inDays}days ago';
    }
  }
}

//duration.inMinutes.abs()
