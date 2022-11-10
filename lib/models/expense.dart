import 'package:goodbye_money/types/recurrence.dart';
import 'package:realm/realm.dart';

import 'package:goodbye_money/models/category.dart';
import 'package:intl/intl.dart';

part 'expense.g.dart';

@RealmModel()
class $Expense {
  @PrimaryKey()
  late final ObjectId id;
  late final double amount;
  late final $Category? category;
  late final DateTime date;
  late final String? note;
  late final String? recurrence = Recurrence.none;

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
