import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/categories.dart';
import '../types/widgets.dart';

class Item {
  final String label;
  final bool isDestructive;

  const Item(this.label, this.isDestructive);
}

const items = [
  Item('Categories', false),
  Item('Erase all data', true),
];

class Settings extends WidgetWithTitle {
  const Settings({super.key}) : super(title: "Settings");

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 147,
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
                                  builder: (context) => const Categories()));
                          break;
                        case 1:
                          _showAlertDialog(context);
                          break;
                      }
                    },
                    child: DecoratedBox(
                      decoration: const BoxDecoration(),
                      child: CupertinoFormRow(
                        prefix: Text(items[index].label,
                            style: TextStyle(
                                color: items[index].isDestructive
                                    ? Colors.red
                                    : Colors.white)),
                        helper: null,
                        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                        child: items[index].isDestructive
                            ? Container()
                            : const Icon(Icons.keyboard_arrow_right_sharp),
                      ),
                    )))
          ])),
    );
  }
}

// This shows a CupertinoModalPopup which hosts a CupertinoAlertDialog.
void _showAlertDialog(BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('Are you sure?'),
      content: const Text('This action cannot be undone.'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          /// This parameter indicates this action is the default,
          /// and turns the action's text to bold text.
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        CupertinoDialogAction(
          /// This parameter indicates the action would perform
          /// a destructive action such as deletion, and turns
          /// the action's text color to red.
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Erase data'),
        ),
      ],
    ),
  );
}
