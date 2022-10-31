import 'package:goodbye_money/extensions/date_extensions.dart';
import 'package:goodbye_money/models/expense.dart';
import 'package:goodbye_money/types/period.dart';

extension ExpensesExtension on List<Expense> {
  List filterByPeriod(Period period, int periodIndex) {
    List<Expense> expenses = [];
    DateTime startDate;
    DateTime endDate;
    DateTime now = DateTime.now();

    switch (period) {
      case Period.day:
        startDate = endDate = now.subtract(Duration(days: periodIndex));
        break;
      case Period.week:
        int diffSinceMonday = now.weekday - 1;
        startDate =
            now.subtract(Duration(days: diffSinceMonday + 7 * periodIndex));
        endDate = startDate.add(const Duration(days: 6));
        break;
      case Period.month:
        startDate = DateTime(now.year, now.month - periodIndex, 1);
        endDate = DateTime(now.year, now.month - periodIndex + 1, 0);
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

    return [expenses, startDate, endDate];
  }

  double sum() {
    double sum = 0;
    forEach((element) {
      sum += element.amount;
    });
    return sum;
  }

  groupWeekly() {
    final Map<String, List<Expense>> grouped = {
      "Monday": [],
      "Tuesday": [],
      "Wednesday": [],
      "Thursday": [],
      "Friday": [],
      "Saturday": [],
      "Sunday": [],
    };

    forEach((element) {
      grouped[element.dayInWeek]!.add(element);
    });

    return grouped;
  }

  groupMonthly(DateTime startDate) {
    final numOfDays = DateTime(startDate.year, startDate.month + 1, 0).day;
    final Map<int, List<Expense>> grouped =
        List.generate(numOfDays, (index) => <Expense>[]).asMap();

    forEach((element) {
      grouped[element.dayInMonth - 1]!.add(element);
    });

    return grouped;
  }

  groupYearly() {
    final Map<int, List<Expense>> grouped =
        List.generate(12, (index) => <Expense>[]).asMap();

    forEach((element) {
      grouped[element.date.month - 1]!.add(element);
    });

    return grouped;
  }
}
