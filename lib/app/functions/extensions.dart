import 'package:intl/intl.dart';

extension FirstWhereOrNull<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T) condition) {
    final data = where((condition)).toList();
    return data.isEmpty ? null : data[0];
  }
}

extension DateTimeExtensions on DateTime {
  String toReadableFormat() {
    return DateFormat('MMMM d, yyyy').format(this);
  }

  String dayName() {
    return DateFormat('EEEE').format(this).toLowerCase();
  }
}
