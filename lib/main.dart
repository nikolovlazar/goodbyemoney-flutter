import 'package:flutter/cupertino.dart';
import 'package:goodbye_money/tabs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
        title: 'Expense Tracker',
        theme: CupertinoThemeData(
            primaryColor: Color.fromARGB(255, 73, 149, 236),
            brightness: Brightness.dark),
        home: TabsController());
  }
}
