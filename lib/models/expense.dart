import 'package:goodbye_money/models/category.dart';
import 'package:goodbye_money/types/recurrence.dart';

import 'package:intl/intl.dart';

class Expense {
  final double amount;
  final Category category;
  final DateTime date;
  final String? note;
  final String recurrence;

  Expense({
    required this.amount,
    required this.category,
    required this.date,
    this.note,
    this.recurrence = Recurrence.none,
  });

  get dayInWeek {
    DateFormat format = DateFormat("EEEE");
    return format.format(date);
  }

  get dayInMonth {
    return date.day;
  }

  get month {
    DateFormat format = DateFormat("MMM");
    return format.format(date);
  }

  get year {
    return date.year;
  }
}
