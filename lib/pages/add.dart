// ignore_for_file: library_private_types_in_public_api
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:goodbye_money/constants.dart';
import 'package:goodbye_money/models/category.dart';
import 'package:goodbye_money/models/expense.dart';
import 'package:goodbye_money/realm.dart';
import 'package:goodbye_money/types/recurrence.dart';
import 'package:goodbye_money/types/widgets.dart';
import 'package:goodbye_money/utils/picker_utils.dart';
import 'package:realm/realm.dart';

var recurrences = List.from(Recurrence.values);

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
  var realmCategories = realm.all<Category>();
  StreamSubscription<RealmResultsChanges<Category>>? _categoriesSub;

  List<Category> categories = [];
  int _selectedRecurrenceIndex = 0;
  int _selectedCategoryIndex = 0;
  DateTime _selectedDate = DateTime.now();
  bool canSubmit = false;

  @override
  void initState() {
    super.initState();

    _amountController = TextEditingController();
    _noteController = TextEditingController();
    categories = realmCategories.toList();
    canSubmit = categories.isNotEmpty && _amountController.text.isNotEmpty;
  }

  @override
  Future<void> dispose() async {
    await _categoriesSub?.cancel();
    super.dispose();
  }

  void submitExpense() {
    realm.write(() => realm.add<Expense>(Expense(
          ObjectId(),
          double.parse(_amountController.value.text),
          _selectedDate,
          category: categories[_selectedCategoryIndex],
          note: _noteController.value.text.isNotEmpty
              ? _noteController.value.text
              : categories[_selectedCategoryIndex].name,
          recurrence: recurrences[_selectedRecurrenceIndex],
        )));

    setState(() {
      _amountController.clear();
      _selectedRecurrenceIndex = 0;
      _selectedDate = DateTime.now();
      _noteController.clear();
      _selectedCategoryIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    _categoriesSub ??= realmCategories.changes.listen((event) {
      categories = event.results.toList();
    });

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        middle: Text("Add"),
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
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: DecoratedBox(
              decoration: const BoxDecoration(),
              child: Column(
                children: [
                  CupertinoFormSection.insetGrouped(children: [
                    DecoratedBox(
                      decoration: const BoxDecoration(),
                      child: CupertinoFormRow(
                        prefix: const Text("Amount",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255))),
                        helper: null,
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                        child: CupertinoTextField.borderless(
                          placeholder: "Amount",
                          controller: _amountController,
                          onChanged: (value) {
                            setState(() => canSubmit =
                                categories.isNotEmpty && value.isNotEmpty);
                          },
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
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255))),
                        helper: null,
                        padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                        child: CupertinoButton(
                          onPressed: () => showPicker(
                            context,
                            CupertinoPicker(
                              scrollController: FixedExtentScrollController(
                                initialItem: _selectedRecurrenceIndex,
                              ),
                              magnification: 1,
                              squeeze: 1.2,
                              useMagnifier: false,
                              itemExtent: kItemExtent,
                              // This is called when selected item is changed.
                              onSelectedItemChanged: (int selectedItem) {
                                setState(() {
                                  _selectedRecurrenceIndex = selectedItem;
                                });
                              },
                              children: List<Widget>.generate(
                                  recurrences.length, (int index) {
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
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255))),
                        helper: null,
                        padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                        child: CupertinoButton(
                          onPressed: () => showPicker(
                            context,
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
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255))),
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
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255))),
                        helper: null,
                        padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                        child: CupertinoButton(
                          onPressed: () => showPicker(
                            context,
                            CupertinoPicker(
                              scrollController: FixedExtentScrollController(
                                  initialItem: _selectedCategoryIndex),
                              magnification: 1,
                              squeeze: 1.2,
                              useMagnifier: false,
                              itemExtent: kItemExtent,
                              // This is called when selected item is changed.
                              onSelectedItemChanged: (int selectedItem) {
                                setState(() {
                                  _selectedCategoryIndex = selectedItem;
                                });
                              },
                              children: List<Widget>.generate(categories.length,
                                  (int index) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 64),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          width: 12,
                                          height: 12,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 8, 0),
                                          decoration: BoxDecoration(
                                            color: categories[index].color,
                                            shape: BoxShape.circle,
                                          )),
                                      Text(categories[index].name),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                          child: Text(
                            categories.isEmpty
                                ? "Create a category first"
                                : categories[_selectedCategoryIndex].name,
                            style: TextStyle(
                              color: categories.isEmpty
                                  ? CupertinoColors.white
                                  : categories[_selectedCategoryIndex].color,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                  Container(
                    margin: const EdgeInsets.only(top: 32),
                    child: CupertinoButton(
                      onPressed: canSubmit ? submitExpense : null,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 13),
                      color: CupertinoTheme.of(context).primaryColor,
                      disabledColor: CupertinoTheme.of(context)
                          .primaryColor
                          .withAlpha(100),
                      borderRadius: BorderRadius.circular(10),
                      pressedOpacity: 0.7,
                      child: Text(
                        "Submit expense",
                        style: TextStyle(
                          color: canSubmit
                              ? const Color.fromARGB(255, 255, 255, 255)
                              : const Color.fromARGB(100, 255, 255, 255),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
