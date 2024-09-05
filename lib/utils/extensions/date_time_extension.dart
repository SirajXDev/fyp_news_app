extension DateTimeExtension on DateTime {
  String timeAgo() {
    final duration = DateTime.now().difference(this);
    if (duration.inMinutes < 60) {
      return '${duration.inMinutes}m ago';
    } else if (duration.inHours < 24) {
      return '${duration.inHours}h ago';
    } else {
      return '${duration.inDays}days ago';
    }
  }
}
