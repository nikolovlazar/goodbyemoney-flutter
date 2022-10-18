import 'package:flutter/material.dart';

import '../types/widgets.dart';

class Add extends WidgetWithTitle {
  const Add({super.key}) : super(title: "Add");

  @override
  Widget build(BuildContext context) {
    return const Text("Add!");
  }
}
