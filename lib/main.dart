import 'package:cached_network_image/cached_network_image.dart';
import 'package:expense_tracker/config/routes/routes.dart';
import 'package:expense_tracker/config/themes/themes.dart';
import 'package:flutter/material.dart';

import 'data/log_status.dart';
import 'data/remote/user_http.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;

  splashCheck();
}

class ExpenseTracker extends StatefulWidget {
  final String initialPage;
  const ExpenseTracker({Key? key, required this.initialPage}) : super(key: key);

  @override
  State<ExpenseTracker> createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      title: 'Expense Income Tracker',
      initialRoute: widget.initialPage,
      onGenerateRoute: AppRoute.onGeneratedRoute,
    );
  }
}

void splashCheck() async {
  String token = await LogStatus().getToken();
  if (token.isEmpty) {
    runApp(ExpenseTracker(initialPage: "/"));
    return;
  }

  LogStatus.token = token;
  try {
    bool checkPassword = await UserHttp().checkPassword();
    if (checkPassword) {
      runApp(ExpenseTracker(initialPage: "/changePassword"));
      return;
    }
  } catch (error) {
    runApp(ExpenseTracker(initialPage: "/home"));
  }

  runApp(ExpenseTracker(initialPage: "/home"));
}
