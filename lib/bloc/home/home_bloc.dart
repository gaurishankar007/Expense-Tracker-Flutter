import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/data/model/home_model.dart';
import 'package:expense_tracker/data/remote/home_http.dart';

import '../../../config/category.dart';
import '../../../data/model/expense_model.dart';
import '../../../data/model/income_model.dart';
import '../../../data/remote/progress_http.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoadingState()) {
    on<HomeLoadedEvent>((event, emit) async {
      emit(HomeLoadingState());

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
      ));
    });
  }
}
