// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:goodbye_money/types/widgets.dart';

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

  @override
  void initState() {
    super.initState();

    _amountController = TextEditingController();
  }

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
            DecoratedBox(
              decoration: const BoxDecoration(),
              child: CupertinoFormRow(
                prefix: const Text("Amount",
                    style:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                helper: null,
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
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
          ])),
    );
  }
}
