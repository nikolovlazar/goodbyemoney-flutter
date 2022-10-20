import 'package:flutter/cupertino.dart';

import 'package:goodbye_money/models/category.dart';
import 'package:goodbye_money/models/expense.dart';
import 'package:goodbye_money/types/recurrence.dart';

var now = DateTime.now();
var yesterday = now.subtract(const Duration(days: 1));
var eightDaysAgo = now.subtract(const Duration(days: 8));
var lastYear = now.subtract(const Duration(days: 365));

var mockExpenses = [
  Expense(
    amount: 659.99,
    category: Category(name: "Takeout", color: CupertinoColors.systemYellow),
    date: DateTime(now.year, now.month, now.day, 16, 24, 13),
    note: "Pizza",
  ),
  Expense(
    amount: 35,
    category: Category(name: "Electronics", color: CupertinoColors.systemGreen),
    date: DateTime(now.year, now.month, now.day, 13, 37, 24),
    note: "Mouse pad",
  ),
  Expense(
    amount: 1200,
    category: Category(name: "Groceries", color: CupertinoColors.systemBlue),
    date: DateTime(now.year, now.month, now.day, 15, 22, 38),
  ),
  Expense(
    amount: 1000,
    category: Category(name: "Bills", color: CupertinoColors.systemRed),
    date: DateTime(now.year, now.month, now.day, 12, 00, 00),
    note: "Internet",
    recurrence: Recurrence.monthly,
  ),
  Expense(
    amount: 150,
    category: Category(name: "Groceries", color: CupertinoColors.systemBlue),
    date: DateTime(yesterday.year, yesterday.month, yesterday.day, 11, 32, 07),
    note: "Milk + Eggs",
  ),
  Expense(
    amount: 315,
    category: Category(name: "Bills", color: CupertinoColors.systemRed),
    date: DateTime(yesterday.year, yesterday.month, yesterday.day, 12, 00, 00),
    note: "Water",
    recurrence: Recurrence.monthly,
  ),
  Expense(
    amount: 119,
    category: Category(name: "Electronics", color: CupertinoColors.systemGreen),
    date: DateTime(
        eightDaysAgo.year, eightDaysAgo.month, eightDaysAgo.day, 18, 52, 48),
    note: "Magic mouse",
  ),
  Expense(
    amount: 30,
    category: Category(name: "Takeout", color: CupertinoColors.systemYellow),
    date: DateTime(
        eightDaysAgo.year, eightDaysAgo.month, eightDaysAgo.day, 21, 13, 22),
    note: "Burgers",
  ),
  Expense(
    amount: 30,
    category: Category(name: "Takeout", color: CupertinoColors.systemYellow),
    date: DateTime(lastYear.year, lastYear.month, lastYear.day, 21, 13, 22),
    note: "Burgers",
  )
];
