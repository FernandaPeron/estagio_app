import 'package:intl/intl.dart';

class DateUtils {

  formatDate(format, date) {
    return new DateFormat(format).format(DateTime.parse(date));
  }

}