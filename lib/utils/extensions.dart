import 'package:intl/intl.dart';

extension TimestampFormatting on int {
  String formatTimestamp() {
    DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(this ~/ 1000);

    DateFormat dateFormat = DateFormat.yMMMMd().add_Hms();

    return dateFormat.format(dateTime);
  }
}
