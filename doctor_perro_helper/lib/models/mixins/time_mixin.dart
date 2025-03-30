import 'package:intl/intl.dart';

mixin TimeMixin {
  String getRelativeTime(DateTime timestamp) {
    DateTime currentTime = DateTime.now();
    Duration difference = currentTime.difference(timestamp);

    if (difference.inSeconds < 60) {
      return "Hace ${difference.inSeconds} segundos";
    } else if (difference.inMinutes < 60) {
      return "Hace ${difference.inMinutes} ${difference.inMinutes > 1 ? "minutos" : "minuto"}";
    } else if (difference.inHours < 24) {
      return "Hace ${difference.inHours} ${difference.inHours > 1 ? "horas" : "hora"}";
    } else if (difference.inDays < 7) {
      return "Hace ${difference.inDays} ${difference.inDays > 1 ? "días" : "día"} ";
    } else {
      return DateFormat("yMMMd").format(timestamp);
    }
  }
}
