import 'package:intl/intl.dart';

String formatTime(String time, DateTime date) {
  return DateFormat('hh:mm aaa')
      .format(DateTime.parse('${DateFormat('yyyy-MM-dd').format(date)} $time'));
}

String formatDataTime(DateTime date) {
  return DateFormat('dd-MM-yyy HH:mm:ss').format(date);
}

String formatDay(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
}

String formatDay2(DateTime date) {
  return DateFormat('MM/dd/yyyy').format(date);
}

String formatDayDash(DateTime date) {
  return DateFormat('yyy-MM-dd').format(date);
}

String formatTime2(DateTime date) {
  return DateFormat('hh:mm aaa').format(date);
}

String formatDayTime(DateTime date) {
  return DateFormat('EEEE, MMMM d yyyy | h:mm A').format(date);
}

// String formatDuration(DateTime date) {
//   return DateFormat('yyyy-MM-ddTHH:mm:ss').format(date);
// }

String formatLL(DateTime date) {
  return DateFormat('MMMM d, yyyy').format(date);
}

String formatDate(DateTime date) {
  return DateFormat('EEEE d MMM, yyyy').format(date);
}

String formatDate2(DateTime date) {
  return DateFormat('MMM d, yyyy').format(date);
}

String formatDayTimeSort(DateTime date) {
  return DateFormat('dd-MM-yyyy | h:mm A').format(date);
}

String formatTime24h(DateTime date) {
  return DateFormat('HH:mm').format(date);
}

String formatDayDash2(DateTime date) {
  return DateFormat('MM-dd-yyyy').format(date);
}

String formatDayString(DateTime date) {
  return DateFormat('EEE, d MMM/yy').format(date);
}

String formatDayString2(DateTime date) {
  return DateFormat('EEEE MMMM d, yyyy').format(date);
}

String formatVND(int number) {
  final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: "");
  return formatter.format(number);
}

DateFormat format_ddMMyyyy = DateFormat("dd/MM/yyyy");
DateFormat format_HHmm = DateFormat("HH:mm");
DateFormat dateFormat_dMyHm = DateFormat("dd/MM/yyyy | HH:mm");
DateFormat dateFormat_dmy = DateFormat("dd/MM/yyyy");
