// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:goodbye_money/types/widgets.dart';

const double _kItemExtent = 32.0;

const recurrences = ["None", "Daily", "Weekly", "Monthly", "Yearly"];
const categories = [
  "Food",
  "Transportation",
  "Entertainment",
  "Bills",
  "Clothing",
  "Other"
];

class Add extends WidgetWithTitle {
  const Add({super.key}) : super(title: "Add");

  @override
  Widget build(BuildContext context) {
    return const AddContent();
  }
}

class AddContent extends StatefulWidget {
  const AddContent({super.key});

  @override
  _AddContentState createState() => _AddContentState();
}

class _AddContentState extends State<AddContent> {
  late TextEditingController _amountController;
  late TextEditingController _noteController;

  int _selectedRecurrenceIndex = 0;
  int _selectedCategoryIndex = 0;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    _amountController = TextEditingController();
    _noteController = TextEditingController();
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      transformAlignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: DecoratedBox(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 28, 28, 30),
              borderRadius: BorderRadius.circular(16),
            ),
            child: CupertinoFormSection.insetGrouped(children: [
              DecoratedBox(
                decoration: const BoxDecoration(),
                child: CupertinoFormRow(
                  prefix: const Text("Amount",
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                  helper: null,
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  child: CupertinoTextField.borderless(
                    placeholder: "Amount",
                    controller: _amountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    textAlign: TextAlign.end,
                    textInputAction: TextInputAction.continueAction,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      backgroundColor: Color.fromARGB(0, 0, 0, 0),
                    ),
                  ),
                ),
              ),
              DecoratedBox(
                decoration: const BoxDecoration(),
                child: CupertinoFormRow(
                  prefix: const Text("Recurrence",
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                  helper: null,
                  padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                  child: CupertinoButton(
                    onPressed: () => _showDialog(
                      CupertinoPicker(
                        magnification: 1.22,
                        squeeze: 1.2,
                        useMagnifier: false,
                        itemExtent: _kItemExtent,
                        // This is called when selected item is changed.
                        onSelectedItemChanged: (int selectedItem) {
                          setState(() {
                            _selectedRecurrenceIndex = selectedItem;
                          });
                        },
                        children: List<Widget>.generate(recurrences.length,
                            (int index) {
                          return Center(
                            child: Text(recurrences[index]),
                          );
                        }),
                      ),
                    ),
                    child: Text(recurrences[_selectedRecurrenceIndex]),
                  ),
                ),
              ),
              DecoratedBox(
                decoration: const BoxDecoration(),
                child: CupertinoFormRow(
                  prefix: const Text("Date",
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                  helper: null,
                  padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                  child: CupertinoButton(
                    onPressed: () => _showDialog(
                      CupertinoDatePicker(
                        initialDateTime: _selectedDate,
                        mode: CupertinoDatePickerMode.dateAndTime,
                        use24hFormat: true,
                        // This is called when the user changes the time.
                        onDateTimeChanged: (DateTime newTime) {
                          setState(() => _selectedDate = newTime);
                        },
                      ),
                    ),
                    child: Text(
                        '${_selectedDate.month}/${_selectedDate.day}/${_selectedDate.year} ${_selectedDate.hour}:${_selectedDate.minute}'),
                  ),
                ),
              ),
              DecoratedBox(
                decoration: const BoxDecoration(),
                child: CupertinoFormRow(
                  prefix: const Text("Note",
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                  helper: null,
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  child: CupertinoTextField.borderless(
                    placeholder: "Note",
                    controller: _noteController,
                    textAlign: TextAlign.end,
                    textInputAction: TextInputAction.continueAction,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      backgroundColor: Color.fromARGB(0, 0, 0, 0),
                    ),
                  ),
                ),
              ),
              DecoratedBox(
                decoration: const BoxDecoration(),
                child: CupertinoFormRow(
                  prefix: const Text("Category",
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                  helper: null,
                  padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                  child: CupertinoButton(
                    onPressed: () => _showDialog(
                      CupertinoPicker(
                        magnification: 1.22,
                        squeeze: 1.2,
                        useMagnifier: false,
                        itemExtent: _kItemExtent,
                        // This is called when selected item is changed.
                        onSelectedItemChanged: (int selectedItem) {
                          setState(() {
                            _selectedCategoryIndex = selectedItem;
                          });
                        },
                        children: List<Widget>.generate(categories.length,
                            (int index) {
                          return Center(
                            child: Text(categories[index]),
                          );
                        }),
                      ),
                    ),
                    child: Text(categories[_selectedCategoryIndex]),
                  ),
                ),
              ),
            ])),
      ),
    );
  }
}
