import 'package:flutter/material.dart';

import '../types/widgets.dart';

class Expenses extends WidgetWithTitle {
  const Expenses({super.key}) : super(title: "Expenses");

  @override
  Widget build(BuildContext context) {
    return const Text("Expenses!");
  }
}
