import 'package:expense_tracker/screen/authentication/enter_token.dart';
import 'package:expense_tracker/screen/authentication/forget_password.dart';
import 'package:expense_tracker/screen/authentication/login.dart';
import 'package:expense_tracker/screen/authentication/sign_up.dart';
import 'package:expense_tracker/screen/expense/expense.dart';
import 'package:expense_tracker/screen/home.dart';
import 'package:expense_tracker/screen/income/income.dart';
import 'package:expense_tracker/screen/progress/achievements.dart';
import 'package:expense_tracker/screen/progress/rank.dart';
import 'package:expense_tracker/screen/progress/result.dart';
import 'package:expense_tracker/screen/setting/setting.dart';
import 'package:expense_tracker/screen/setting/change_password.dart';
import 'package:expense_tracker/screen/setting/user_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/home_model.dart';

class AppRoute {
  static Route? onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return _materialRoute(Login());
      case "/register":
        return _materialRoute(SignUp());
      case "/forgotPassword":
        return _materialRoute(ForgetPassword());
      case "/verifyToken":
        return _materialRoute(VerifyToken(
          userId: settings.arguments as String?,
        ));
      case "/changePassword":
        return _materialRoute(ChangePassword());
      case "/home":
        return _materialRoute(
          MultiRepositoryProvider(
            providers: [
              RepositoryProvider(
                create: (context) => HomeData(),
              ),
            ],
            child: Home(),
          ),
        );
      case "/income":
        return _materialRoute(IncomePage());
      case "/expense":
        return _materialRoute(ExpensePage());
      case "/result":
        return _materialRoute(Result());
      case "/rank":
        return _materialRoute(RankingSystem());
      case "/achievement":
        return _materialRoute(AllAchievements());
      case "/Setting":
        return _materialRoute(Setting());
      case "/userSetting":
        return _materialRoute(UserSetting());
      case "/passwordSetting":
        return _materialRoute(ChangePassword());
      default:
        return null;
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (context) => view);
  }
}
