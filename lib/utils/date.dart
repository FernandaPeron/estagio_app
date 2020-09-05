import 'package:intl/intl.dart';

class DateUtils {

  formatDate(format, date) {
    return new DateFormat(format, 'pt_BR').format(DateTime.parse(date));
  }

}