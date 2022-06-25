import 'package:flutter/material.dart';

import 'api/log_status.dart';
import 'screen/authentication/login.dart';
import 'screen/home.dart';

void main() {
  WidgetsFlutterBinding();

  LogStatus().getToken().then(
    (value) {
      if (value.isNotEmpty) {
        LogStatus.token = value;

        runApp(const ExpenseTracker(initialPage: Home()));
      } else {
        runApp(const ExpenseTracker(initialPage: Login()));
      }
    },
  );
}

class ExpenseTracker extends StatefulWidget {
  final Widget? initialPage;
  const ExpenseTracker({
    Key? key,
    @required this.initialPage,
  }) : super(key: key);

  @override
  State<ExpenseTracker> createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      title: 'Expense Income Tracker',
      home: widget.initialPage,
    );
  }
}
