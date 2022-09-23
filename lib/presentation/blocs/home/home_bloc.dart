import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/core/resources/internet_check.dart';
import 'package:expense_tracker/data/model/home_model.dart';
import 'package:expense_tracker/data/remote/home_http.dart';

import '../../../config/category.dart';
import '../../../data/model/expense_model.dart';
import '../../../data/model/income_model.dart';
import '../../../data/remote/progress_http.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  // final HomeData homeData;
  // final CheckInternet checkInternet;

  HomeBloc(
    // this.homeData,
    // this.checkInternet,
  ) : super(HomeLoadingState()) {
    CheckInternet().connectivityStream.stream.listen((event) {
      if (event == ConnectivityResult.none) {
        print("no internet");
        add(NoInternetEvent());
      } else {
        print("internet");
        add(HomeLoadedEvent());
      }
    });

    on<HomeLoadedEvent>((event, emit) async {
      emit(HomeLoadingState());

      int curTime = DateTime.now().hour;
      String greeting = "Expense Tracker";

      if (5 <= curTime && 12 >= curTime) {
        greeting = "Good Morning";
      } else if (12 <= curTime && 18 >= curTime) {
        greeting = "Good Afternoon";
      } else {
        greeting = "Good Evening";
      }

      HomeData homeData = await HomeHttp().viewHome();
      List<ExpenseCategorized> e = homeData.thisMonthExpenseCategories!;
      List<IncomeCategorized> i = homeData.thisMonthIncomeCategories!;

      List<String> expenseCategories = [];
      List<String> incomeCategories = [];

      if (e.isEmpty) {
        expenseCategories = Category.expenseCategory;
      } else {
        expenseCategories = e
            .asMap()
            .map((key, value) {
              return MapEntry(key, e[key].category!);
            })
            .values
            .toList();
      }

      if (i.isEmpty) {
        incomeCategories = Category.incomeCategory;
      } else {
        incomeCategories = i
            .asMap()
            .map((key, value) {
              return MapEntry(key, i[key].category!);
            })
            .values
            .toList();
      }

      final pc = await ProgressHttp().calculateProgress();
      bool achievementUnlocked = pc["achievementUnlocked"];

      emit(HomeLoadedState(
        homeData: homeData,
        expenseCategories: expenseCategories,
        incomeCategories: incomeCategories,
        achievementUnlocked: achievementUnlocked,
        greeting: greeting,
      ));
    });

    on<NoInternetEvent>((event, emit) {
      emit(NoInternetState());
    });
  }
}
