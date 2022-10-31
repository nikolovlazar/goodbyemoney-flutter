import 'package:flutter/cupertino.dart';

import 'package:goodbye_money/components/day_expenses.dart';
import 'package:goodbye_money/extensions/date_extensions.dart';
import 'package:goodbye_money/models/expense.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;

  const ExpensesList({
    super.key,
    required this.expenses,
  });

  Map<DateTime, List<Expense>> _computeExpenses(List<Expense> expenses) {
    Map<DateTime, List<Expense>> groups = {};
    for (final Expense expense in expenses) {
      final DateTime date = expense.date.simpleDate;
      if (groups.containsKey(date)) {
        groups[date]!.add(expense);
      } else {
        groups[date] = [expense];
      }
    }
    return Map.fromEntries(groups.entries.toList()
      ..sort((el1, el2) => el2.key.compareTo(el1.key)));
  }

  @override
  Widget build(BuildContext context) {
    var displayedExpenses = _computeExpenses(expenses);

    return CupertinoScrollbar(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: displayedExpenses.length,
        itemBuilder: (context, index) {
          final DateTime date = displayedExpenses.keys.elementAt(index);
          final List<Expense> dayExpenses = displayedExpenses[date]!;

          if (dayExpenses.isEmpty) {
            return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Text('No expenses for period'));
          }

          return DayExpenses(date: date, expenses: dayExpenses);
        },
      ),
    );
  }
}
