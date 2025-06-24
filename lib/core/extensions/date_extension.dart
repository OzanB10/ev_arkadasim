import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String toFormattedDate() {
    return DateFormat('dd/MM/yyyy').format(this);
  }
  
  String toFormattedDateTime() {
    return DateFormat('dd/MM/yyyy HH:mm').format(this);
  }
  
  String toMonthYear() {
    return DateFormat('MMMM yyyy', 'tr_TR').format(this);
  }
  
  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }
  
  DateTime get startOfMonth {
    return DateTime(year, month, 1);
  }
  
  DateTime get endOfMonth {
    return DateTime(year, month + 1, 0, 23, 59, 59);
  }
} 