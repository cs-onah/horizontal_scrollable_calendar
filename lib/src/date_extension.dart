extension DateExt on DateTime {
  DateTime get monthOnly => DateTime(year, month);
  DateTime get dayOnly => DateTime(year, month, day);
}