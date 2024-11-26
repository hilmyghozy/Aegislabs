import 'package:intl/intl.dart';

extension DoubleExtension on double? {
  String formatCurrency() {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'IDR');
    if (this == null) return '-';

    // Format the amount with currency symbol
    return formatter.format(this);
  }

  String formatVoucher(String type) {
    if (type == "Fixed") {
      return formatCurrency();
    }

    return "${this?.toInt()}% OFF";
  }
}
