import 'package:intl/intl.dart';

class TimeUtils {
  static String formatTimeString(int time) {
    final f = new DateFormat('yyyy-MM-dd hh:mm');
    return f.format(new DateTime.fromMillisecondsSinceEpoch(time));
  }
}