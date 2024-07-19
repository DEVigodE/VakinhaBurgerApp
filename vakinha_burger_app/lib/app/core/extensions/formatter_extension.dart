import 'package:intl/intl.dart';

extension FormatterExtension on double {
  String get currencyPTBR {
    return NumberFormat.currency(locale: 'pt_BR', symbol: r'R$').format(this);
  }
}
