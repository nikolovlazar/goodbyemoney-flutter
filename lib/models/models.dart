import 'package:realm/realm.dart';
import 'dart:ui';

import 'package:goodbye_money/models/category.dart';
import 'package:intl/intl.dart';

part 'models.g.dart';

@RealmModel()
class _Category {
  @PrimaryKey()
  late final ObjectId id;
  late final String name;
  // late final Color color;

  // Category({
  //   required this.name,
  //   required this.color,
  // });
}

@RealmModel()
class _Expense {
  @PrimaryKey()
  late final ObjectId id;
  late final double amount;
  late final _Category? category;
  late final DateTime date;
  late final String? note;
  late final String recurrence;

  // Expense({
  //   required this.amount,
  //   required this.category,
  //   required this.date,
  //   this.note,
  //   this.recurrence = Recurrence.none,
  // });

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
