import 'package:intl/intl.dart';

extension DateExtensions on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isToday() {
    DateTime today = DateTime.now();
    return today.year == year && today.month == month && today.day == day;
  }

  bool isYesterday() {
    DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.year == year &&
        yesterday.month == month &&
        yesterday.day == day;
  }

  bool isBetween(DateTime startDate, DateTime endDate) {
    return isAfter(startDate) && isBefore(endDate);
  }

  get formattedDate {
    DateFormat format;
    if (year != DateTime.now().year) {
      format = DateFormat("E, d MMM yyyy");
    } else if (isToday()) {
      return "Today";
    } else if (isYesterday()) {
      return "Yesterday";
    } else {
      format = DateFormat("E, d MMM");
    }

    return format.format(this);
  }

  get shortDate {
    DateFormat format = DateFormat("d MMM");
    return format.format(this);
  }

  get simpleDate {
    return DateTime(year, month, day);
  }

  get nameOfDay {
    DateFormat format = DateFormat("EEEE");
    return format.format(this);
  }

  get time {
    DateFormat format = DateFormat("HH:mm");
    return format.format(this);
  }
}
