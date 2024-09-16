import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String get dateTimeFullFormat =>
      DateFormat('hh:mm a, EEEE MMMM dd, yyyy').format(this);
}
