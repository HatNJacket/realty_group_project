import 'package:intl/intl.dart';
String numToCurrency(double num) {
    bool hasDecimals = num % 1 != 0 || num < 1000;
    final formatter = NumberFormat.currency(locale: 'en_US', decimalDigits: hasDecimals ? 2 : 0, symbol: '\$');
    return formatter.format(num);
 }