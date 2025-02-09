import 'package:intl/intl.dart';

extension DateExt on DateTime {
  DateTime get monthOnly => DateTime(year, month);
  DateTime get dayOnly => DateTime(year, month, day);

  String? get dateReadable {
    return DateFormat('dd MMM, yyyy').format(this);
  }

  bool get isToday {
    final now = DateTime.now();
    return now.dateReadable == dateReadable;
  }

}