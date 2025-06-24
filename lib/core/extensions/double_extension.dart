import 'package:intl/intl.dart';

extension DoubleExtension on double {
  String toCurrency() {
    final formatter = NumberFormat.currency(
      locale: 'tr_TR',
      symbol: '₺',
      decimalDigits: 2,
    );
    return formatter.format(this);
  }
  
  String toFormattedString() {
    return NumberFormat('#,##0.00', 'tr_TR').format(this);
  }
} 