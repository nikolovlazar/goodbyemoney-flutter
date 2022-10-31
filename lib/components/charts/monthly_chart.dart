import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

import 'package:goodbye_money/extensions/expenses_extensions.dart';
import 'package:goodbye_money/models/expense.dart';
import 'package:goodbye_money/utils/chart_utils.dart';

class MonthlyChart extends StatelessWidget {
  final List<Expense> expenses;
  final DateTime startDate;
  final DateTime endDate;

  const MonthlyChart(
      {super.key,
      required this.expenses,
      required this.startDate,
      required this.endDate});

  Map<int, List<Expense>> get groupedExpenses =>
      expenses.groupMonthly(startDate);

  Widget getTitles(double value, TitleMeta meta) {
    if (value % 5 != 0) {
      return Container();
    }

    const style = TextStyle(
      color: CupertinoColors.systemGrey,
      fontSize: 16,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text("${value.toInt()}", style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 55,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 32),
      height: 147,
      child: BarChart(
        BarChartData(
          barGroups: List.generate(
              groupedExpenses.length,
              (index) => makeGroupData(
                  index, groupedExpenses[index]?.sum() ?? 0.0, 6)),
          titlesData: titlesData,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
          ),
        ),
      ),
    );
  }
}
