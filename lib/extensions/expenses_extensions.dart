import 'package:goodbye_money/extensions/date_extensions.dart';
import 'package:goodbye_money/models/expense.dart';
import 'package:goodbye_money/types/period.dart';

extension ExpensesExtension on List<Expense> {
  List<Expense> filterByPeriod(Period period, int periodIndex) {
    List<Expense> expenses = [];
    DateTime startDate;
    DateTime endDate;
    DateTime now = DateTime.now();

    switch (period) {
      case Period.day:
        startDate = endDate = now.subtract(Duration(days: periodIndex));
        break;
      case Period.week:
        int diffSinceMonday = now.weekday;
        startDate =
            now.subtract(Duration(days: diffSinceMonday + 7 * periodIndex));
        endDate = now.add(const Duration(days: 7));
        break;
      case Period.month:
        startDate = DateTime(now.year, now.month, 1);
        endDate = DateTime(now.year, now.month + 1, 0);
        break;
      case Period.year:
        startDate = DateTime(now.year - 1, 1, 1);
        endDate = DateTime(now.year, 12, 31);
        break;
    }

    startDate =
        DateTime(startDate.year, startDate.month, startDate.day, 0, 0, 0);
    endDate = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);

    forEach((element) {
      if (element.date.isBetween(startDate, endDate)) {
        expenses.add(element);
      }
    });

    return expenses;
  }
}
