import 'package:cached_network_image/cached_network_image.dart';
import 'package:expense_tracker/config/routes/routes.dart';
import 'package:flutter/material.dart';

import 'data/log_status.dart';
import 'config/themes/constant.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Container(
        color: AppColor.primary,
        child: Center(
          child: Text(
            details.exception.toString(),
            textAlign: TextAlign.center,
            softWrap: true,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  };

  LogStatus().getToken().then(
    (value) {
      if (value.isNotEmpty) {
        LogStatus.token = value;

        runApp(const ExpenseTracker(initialPage: "/home"));
      } else {
        runApp(const ExpenseTracker(initialPage: "/"));
      }
    },
  );
}

class ExpenseTracker extends StatefulWidget {
  final String? initialPage;
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
      theme: ThemeData(
        scaffoldBackgroundColor: AppColor.backgroundLight,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Expense Income Tracker',
      initialRoute: widget.initialPage,
      onGenerateRoute: AppRoute.onGeneratedRoute,
    );
  }
}
