import 'package:intl/intl.dart';

mixin TimeMixin {
  String getRelativeTime(DateTime timestamp) {
    DateTime currentTime = DateTime.now();
    Duration difference = currentTime.difference(timestamp);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('yMMMd').format(timestamp);
    }
  }
}
