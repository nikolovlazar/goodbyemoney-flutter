// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:goodbye_money/models/category.dart';
import 'package:goodbye_money/models/expense.dart';
import 'package:goodbye_money/pages/report_bug.dart';
import 'package:goodbye_money/realm.dart';
import 'package:goodbye_money/utils/destructive_prompt.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../pages/categories.dart';
import '../types/widgets.dart';

class Item {
  final String label;
  final bool isDestructive;

  const Item(this.label, this.isDestructive);
}

const items = [
  Item('Categories', false),
  Item('Report a bug', false),
  Item('Erase all data', true),
];

class Settings extends WidgetWithTitle {
  const Settings({super.key}) : super(title: "Settings");

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        middle: Text("Settings"),
      ),
      child: SafeArea(
        left: true,
        top: true,
        right: true,
        bottom: true,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          transformAlignment: Alignment.center,
          child: DecoratedBox(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 28, 28, 30),
                borderRadius: BorderRadius.circular(16),
              ),
              child: CupertinoFormSection.insetGrouped(children: [
                ...List.generate(
                    items.length,
                    (index) => GestureDetector(
                        onTap: () {
                          switch (index) {
                            case 0:
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const Categories()));
                              break;
                            case 1:
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => const ReportBug()));
                              break;
                            case 2:
                              showAlertDialog(
                                context,
                                () {
                                  realm.write(() {
                                    realm.deleteAll<Expense>();
                                    realm.deleteAll<Category>();
                                  });
                                },
                                "Are you sure?",
                                "This action cannot be undone.",
                                "Erase data",
                              );
                              break;
                          }
                        },
                        child: DecoratedBox(
                          decoration: const BoxDecoration(),
                          child: CupertinoFormRow(
                            prefix: Text(items[index].label,
                                style: TextStyle(
                                    color: items[index].isDestructive
                                        ? const Color.fromARGB(255, 255, 69, 58)
                                        : const Color.fromARGB(
                                            255, 255, 255, 255))),
                            helper: null,
                            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                            child: items[index].isDestructive
                                ? Container()
                                : const Icon(CupertinoIcons.chevron_right),
                          ),
                        )))
              ])),
        ),
      ),
    );
  }
}
