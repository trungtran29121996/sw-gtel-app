import 'package:intl/intl.dart';

String formatTime(String time, DateTime date) {
  return DateFormat('hh:mm aaa')
      .format(DateTime.parse('${DateFormat('yyyy-MM-dd').format(date)} $time'));
}

String formatDataTime(DateTime date) {
  return DateFormat('dd/MM/yyy HH:mm:ss').format(date);
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

String formatVND(int? number) {
  if (number != null) {
    // xử lý
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: "");
    return formatter.format(number);
  }
  return "";
}

int formatDaysToDate(String days, int hour, int min) {
  DateFormat format = DateFormat("dd/MM/yyyy");
  DateTime parsedDate = format.parse(days);

  DateTime dateTimeWithTime = DateTime(
    parsedDate.year,
    parsedDate.month,
    parsedDate.day,
    hour,
    min,
  );

  return dateTimeWithTime.millisecondsSinceEpoch;
}

String dayOfWeekNow() {
  DateTime now = DateTime.now();
  String dayOfWeek = DateFormat.EEEE('vi').format(now);
  return dayOfWeek;
}

String dateNow() {
  DateTime now = DateTime.now();
  String date = DateFormat('dd/MM/yyyy').format(now);
  return date;
}

String daysMon() {
  DateTime now = DateTime.now();

  // Lùi lại tới thứ Hai đầu tuần
  DateTime monday = now.subtract(Duration(days: now.weekday - 1));

  // Format ngày theo dd/MM/yyyy
  String mondayStr = DateFormat('dd/MM/yyyy').format(monday);

  return mondayStr;
}

String daysSun() {
  DateTime now = DateTime.now();

  // Lùi lại tới thứ Hai đầu tuần
  DateTime monday = now.subtract(Duration(days: now.weekday - 1));

  // Tính tới Chủ Nhật cuối tuần
  DateTime sunday = monday.add(Duration(days: 6));

  // Format ngày theo dd/MM/yyyy
  String sundayStr = DateFormat('dd/MM/yyyy').format(sunday);

  return sundayStr;
}

DateFormat format_HHmm = DateFormat("HH:mm");
DateFormat dateFormat_dMyHm = DateFormat("dd/MM/yyyy | HH:mm");
DateFormat dateFormat_dmy = DateFormat("dd/MM/yyyy");
DateFormat format = DateFormat("dd/MM/yyyy HH:mm:ss");

String startTime(String inputTime) {
  String dateTime = "";
  DateTime startTime = format.parse(inputTime);
  // Thời gian hiện tại
  DateTime now = DateTime.now();

// Tính chênh lệch
  Duration difference = now.difference(startTime);
  int days = difference.inDays;
  int hours = difference.inHours % 24;
  int minutes = difference.inMinutes % 60;

  if (days > 0) {
    dateTime = "${days.abs()} ngày";
  } else if (days <= 0 && hours > 0) {
    dateTime = "${hours.abs()} giờ ${minutes.abs()} phút";
  } else if (days <= 0 && hours <= 0) {
    dateTime = "${minutes.abs()} phút";
  }

  return dateTime;
}
