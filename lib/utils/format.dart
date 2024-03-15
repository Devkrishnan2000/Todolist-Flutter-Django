import 'package:intl/intl.dart';

class Format {
  static const dateTimeFormat = "dd-MM-yy  hh:mm:ss a";
  String formatDate(DateTime date) {
    final formatter = DateFormat(Format.dateTimeFormat);
    return formatter.format(date);
  }
}
