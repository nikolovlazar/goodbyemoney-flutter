// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages
import 'package:flutter/cupertino.dart';
import 'package:collection/collection.dart';

import 'package:goodbye_money/components/expenses_list.dart';
import 'package:goodbye_money/extensions/number_extensions.dart';
import 'package:goodbye_money/extensions/expenses_extensions.dart';
import 'package:goodbye_money/constants.dart';
import 'package:goodbye_money/mock/mock_expenses.dart';
import 'package:goodbye_money/models/expense.dart';
import 'package:goodbye_money/types/period.dart';
import 'package:goodbye_money/types/widgets.dart';
import 'package:goodbye_money/utils/picker_utils.dart';

class Expenses extends WidgetWithTitle {
  const Expenses({super.key}) : super(title: "Expenses");

  @override
  Widget build(BuildContext context) {
    return const ExpensesContent();
  }
}

class ExpensesContent extends StatefulWidget {
  const ExpensesContent({super.key});

  @override
  _ExpensesContent createState() => _ExpensesContent();
}

class _ExpensesContent extends State<ExpensesContent> {
  int _selectedPeriodIndex = 1;
  Period get _selectedPeriod => periods[_selectedPeriodIndex];

  List<Expense> get _expenses =>
      mockExpenses.filterByPeriod(_selectedPeriod, 0)[0];

  double get _total => _expenses.map((expense) => expense.amount).sum;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        middle: Text("Expenses"),
      ),
      child: SafeArea(
        left: true,
        top: true,
        right: true,
        bottom: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Total for: "),
                CupertinoButton(
                  onPressed: () => showPicker(
                    context,
                    CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                          initialItem: _selectedPeriodIndex),
                      magnification: 1,
                      squeeze: 1.2,
                      useMagnifier: false,
                      itemExtent: kItemExtent,
                      // This is called when selected item is changed.
                      onSelectedItemChanged: (int selectedItem) {
                        setState(() {
                          _selectedPeriodIndex = selectedItem;
                        });
                      },
                      children:
                          List<Widget>.generate(periods.length, (int index) {
                        return Center(
                          child: Text(getPeriodDisplayName(periods[index])),
                        );
                      }),
                    ),
                  ),
                  child: Text(getPeriodDisplayName(_selectedPeriod)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 4, 4, 0),
                  child: const Text("\$",
                      style: TextStyle(
                        fontSize: 20,
                        color: CupertinoColors.inactiveGray,
                      )),
                ),
                Text(_total.removeDecimalZeroFormat(),
                    style: const TextStyle(
                      fontSize: 40,
                    )),
              ],
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(12, 16, 12, 0),
                child: ExpensesList(expenses: _expenses),
              ),
            )
          ],
        ),
      ),
    );
  }
}
