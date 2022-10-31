import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

import 'package:goodbye_money/extensions/expenses_extensions.dart';
import 'package:goodbye_money/models/expense.dart';
import 'package:goodbye_money/utils/chart_utils.dart';

class WeeklyChart extends StatelessWidget {
  final List<Expense> expenses;

  const WeeklyChart({super.key, required this.expenses});

  Map<String, List<Expense>> get groupedExpenses => expenses.groupWeekly();

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: CupertinoColors.systemGrey,
      fontSize: 16,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'M';
        break;
      case 1:
        text = 'T';
        break;
      case 2:
        text = 'W';
        break;
      case 3:
        text = 'T';
        break;
      case 4:
        text = 'F';
        break;
      case 5:
        text = 'S';
        break;
      case 6:
        text = 'S';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
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
          barGroups: [
            makeGroupData(0, groupedExpenses["Monday"]?.sum() ?? 0.0, 39),
            makeGroupData(1, groupedExpenses["Tuesday"]?.sum() ?? 0.0, 39),
            makeGroupData(2, groupedExpenses["Wednesday"]?.sum() ?? 0.0, 39),
            makeGroupData(3, groupedExpenses["Thursday"]?.sum() ?? 0.0, 39),
            makeGroupData(4, groupedExpenses["Friday"]?.sum() ?? 0.0, 39),
            makeGroupData(5, groupedExpenses["Saturday"]?.sum() ?? 0.0, 39),
            makeGroupData(6, groupedExpenses["Sunday"]?.sum() ?? 0.0, 39),
          ],
          titlesData: titlesData,
          gridData: FlGridData(
            show: false,
          ),
        ),
      ),
    );
  }
}
