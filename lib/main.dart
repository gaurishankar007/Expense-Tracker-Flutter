import 'package:cached_network_image/cached_network_image.dart';
import 'package:expense_tracker/config/routes/routes.dart';
import 'package:expense_tracker/config/themes/themes.dart';
import 'package:expense_tracker/data/local/models/token_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/local/login_data.dart';
import 'data/remote/user_http.dart';

late Box box;

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
  await Hive.initFlutter();
  Hive.registerAdapter(TokenDataAdapter());
  await Hive.openBox<TokenData>("TokenData");

  TokenData? tokenData = LoginData().getTokenData();
  if (tokenData == null) {
    runApp(ExpenseTracker(initialPage: "/"));
    return;
  }

  LoginData.token = tokenData.token;
  LoginData.profileName = tokenData.profileName;
  LoginData.profilePicture = tokenData.profilePicture;
  LoginData.googleSignIn = tokenData.googleSignIn;

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
