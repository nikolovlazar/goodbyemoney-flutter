import 'package:flutter/cupertino.dart';
import 'package:realm/realm.dart';

import 'package:goodbye_money/models/category.dart';
import 'package:goodbye_money/models/expense.dart';
import 'package:goodbye_money/types/recurrence.dart';

var now = DateTime.now();
var yesterday = now.subtract(const Duration(days: 1));
var twoDaysAgo = now.subtract(const Duration(days: 2));
var threeDaysAgo = now.subtract(const Duration(days: 3));
var eightDaysAgo = now.subtract(const Duration(days: 8));
var lastYear = now.subtract(const Duration(days: 365));

var mockExpenses = [
  Expense(
    ObjectId(),
    659.99,
    DateTime(now.year, now.month, now.day, 16, 24, 13),
    note: "Pizza",
    category: Category("Takeout", CupertinoColors.systemYellow.color.value),
  ),
  Expense(
    ObjectId(),
    35,
    DateTime(now.year, now.month, now.day, 13, 37, 24),
    category: Category("Electronics", CupertinoColors.systemGreen.color.value),
    note: "Mouse pad",
  ),
  Expense(
    ObjectId(),
    1200,
    DateTime(now.year, now.month, now.day, 15, 22, 38),
    category: Category("Groceries", CupertinoColors.systemBlue.color.value),
  ),
  Expense(
    ObjectId(),
    1000,
    DateTime(now.year, now.month, now.day, 12, 00, 00),
    category: Category("Bills", CupertinoColors.systemRed.color.value),
    note: "Internet",
    recurrence: Recurrence.monthly,
  ),
  Expense(
    ObjectId(),
    150,
    DateTime(yesterday.year, yesterday.month, yesterday.day, 11, 32, 07),
    category: Category("Groceries", CupertinoColors.systemBlue.color.value),
    note: "Milk + Eggs",
  ),
  Expense(
    ObjectId(),
    315,
    DateTime(yesterday.year, yesterday.month, yesterday.day, 12, 00, 00),
    category: Category("Bills", CupertinoColors.systemRed.color.value),
    note: "Water",
    recurrence: Recurrence.monthly,
  ),
  Expense(
    ObjectId(),
    119,
    DateTime(twoDaysAgo.year, twoDaysAgo.month, twoDaysAgo.day, 18, 52, 48),
    category: Category("Electronics", CupertinoColors.systemGreen.color.value),
    note: "Magic mouse",
  ),
  Expense(
    ObjectId(),
    315,
    DateTime(
        threeDaysAgo.year, threeDaysAgo.month, threeDaysAgo.day, 12, 00, 00),
    category: Category("Bills", CupertinoColors.systemRed.color.value),
    note: "Water",
    recurrence: Recurrence.monthly,
  ),
  Expense(
    ObjectId(),
    30,
    DateTime(
        eightDaysAgo.year, eightDaysAgo.month, eightDaysAgo.day, 21, 13, 22),
    category: Category("Takeout", CupertinoColors.systemYellow.color.value),
    note: "Burgers",
  ),
  Expense(
    ObjectId(),
    30,
    DateTime(lastYear.year, lastYear.month, lastYear.day, 21, 13, 22),
    category: Category("Takeout", CupertinoColors.systemYellow.color.value),
    note: "Burgers",
  )
];
