import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goodbye_money/components/expense_row.dart';

import 'package:goodbye_money/extensions/date_extensions.dart';
import 'package:goodbye_money/extensions/expenses_extensions.dart';
import 'package:goodbye_money/extensions/number_extensions.dart';
import 'package:goodbye_money/models/expense.dart';

class DayExpenses extends StatelessWidget {
  final DateTime date;
  final List<Expense> expenses;

  const DayExpenses({
    super.key,
    required this.date,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(date.formattedDate,
              style: const TextStyle(
                color: CupertinoColors.inactiveGray,
                fontWeight: FontWeight.w500,
              )),
          const Divider(
            thickness: 2,
            color: CupertinoColors.darkBackgroundGray,
          ),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: expenses
                .map((expense) => Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: ExpenseRow(
                      expense: expense,
                    )))
                .toList(),
          ),
          const Divider(
            thickness: 2,
            color: CupertinoColors.darkBackgroundGray,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Expanded(
                child: Text(
                  "Total:",
                  style: TextStyle(
                    color: CupertinoColors.inactiveGray,
                  ),
                ),
              ),
              Text(
                "USD ${expenses.sum().removeDecimalZeroFormat()}",
                style: const TextStyle(
                  color: CupertinoColors.inactiveGray,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
