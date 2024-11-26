import 'package:intl/intl.dart';

extension IntExtension on int? {
  String seperatedThousand() {
    NumberFormat formatter = NumberFormat.decimalPatternDigits(
      locale: 'id_ID',
      decimalDigits: 0,
    );
    if (this == null) return '-';
    return formatter.format(this);
  }
}
