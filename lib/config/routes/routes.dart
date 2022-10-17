import 'package:expense_tracker/core/resources/internet_check.dart';
import 'package:expense_tracker/presentation/blocs/home/home_bloc.dart';
import 'package:expense_tracker/presentation/blocs/income/income_bloc.dart';
import 'package:expense_tracker/presentation/blocs/internet/internet_bloc.dart';
import 'package:expense_tracker/presentation/screens/authentication/enter_token.dart';
import 'package:expense_tracker/presentation/screens/authentication/forget_password.dart';
import 'package:expense_tracker/presentation/screens/authentication/login.dart';
import 'package:expense_tracker/presentation/screens/authentication/sign_up.dart';
import 'package:expense_tracker/presentation/screens/expense/categorized_expense.dart';
import 'package:expense_tracker/presentation/screens/expense/expense.dart';
import 'package:expense_tracker/presentation/screens/help.dart';
import 'package:expense_tracker/presentation/screens/home.dart';
import 'package:expense_tracker/presentation/screens/income/categorized_income.dart';
import 'package:expense_tracker/presentation/screens/income/income.dart';
import 'package:expense_tracker/presentation/screens/progress/achievements.dart';
import 'package:expense_tracker/presentation/screens/progress/rank.dart';
import 'package:expense_tracker/presentation/screens/progress/result.dart';
import 'package:expense_tracker/presentation/screens/setting/password_setting.dart';
import 'package:expense_tracker/presentation/screens/setting/setting.dart';
import 'package:expense_tracker/presentation/screens/setting/change_password.dart';
import 'package:expense_tracker/presentation/screens/setting/user_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          BlocProvider(
            create: (_) => HomeBloc()..add(HomeLoadedEvent()),
            child: BlocListener<InternetBloc, InternetState>(
              listener: (context, state) {
                if (state.connected) {
                  BlocProvider.of<HomeBloc>(context).add(HomeLoadedEvent());
                } else {
                  BlocProvider.of<HomeBloc>(context)
                      .add(HomeLoadingEvent(internet: false));
                }
              },
              child: Home(),
            ),
          ),
        );

      case "/categorizedIncome":
        return _materialRoute(CategorizedIncome(
          category: settings.arguments as String?,
        ));

      case "/categorizedExpense":
        return _materialRoute(CategorizedExpense(
          category: settings.arguments as String?,
        ));

      case "/income":
        return _materialRoute(
          BlocProvider(
            create: (_) => IncomeBloc()
              ..add(IncomeLoadedEvent()),
            child: BlocListener<InternetBloc, InternetState>(
              listener: (context, state) {
                if (state.connected) {
                  BlocProvider.of<IncomeBloc>(context)
                      .add(IncomeLoadedEvent());
                } else {
                  BlocProvider.of<IncomeBloc>(context)
                      .add(IncomeLoadingEvent(internet: false));
                }
              },
              child: IncomePage(),
            ),
          ),
        );

      case "/expense":
        return _materialRoute(ExpensePage());

      case "/result":
        return _materialRoute(Result());

      case "/rankingSystem":
        return _materialRoute(RankingSystem());

      case "/achievement":
        return _materialRoute(AllAchievements());

      case "/setting":
        return _materialRoute(Setting());

      case "/passwordSetting":
        return _materialRoute(PasswordSetting());

      case "/userSetting":
        return _materialRoute(UserSetting());

      case "/help":
        return _materialRoute(Help());

      default:
        return null;
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (context) => view);
  }
}
