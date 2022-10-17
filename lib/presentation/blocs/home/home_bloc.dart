import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/data/model/home_model.dart';
import 'package:expense_tracker/data/remote/home_http.dart';

import '../../../config/category.dart';
import '../../../data/model/expense_model.dart';
import '../../../data/model/income_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoadingState(internet: true)) {
    on<HomeLoadingEvent>((event, emit) {
      emit(HomeLoadingState(internet: event.internet));
    });

    on<HomeLoadedEvent>((event, emit) async {
      emit(HomeLoadingState(internet: true));

      int curTime = DateTime.now().hour;
      String greeting = "Expense Tracker";

      if (5 <= curTime && 12 >= curTime) {
        greeting = "Good Morning";
      } else if (12 <= curTime && 18 >= curTime) {
        greeting = "Good Afternoon";
      } else {
        greeting = "Good Evening";
      }

      try {
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

        emit(HomeLoadedState(
          greeting: greeting,
          homeData: homeData,
          moreExpense: false,
          moreIncome: false,
          expenseCategories: expenseCategories,
          incomeCategories: incomeCategories,
        ));
      } catch (error) {
        if (error.toString().split(":").first == "SocketException") {
          emit(HomeLoadingState(internet: false));
        } else {
          emit(ErrorState());
        }
      }
    });

    on<MICEvent>((event, emit) {
      bool more = event.moreIncome;
      List<IncomeCategorized> category =
          event.homeData.thisMonthIncomeCategories!;
      List<String> incomeCategories = event.incomeCategories;

      if (more) {
        List<String> tempCategory = category
            .asMap()
            .map((key, value) {
              return MapEntry(key, category[key].category!);
            })
            .values
            .toList();

        emit(HomeLoadedState(
          greeting: event.greeting,
          homeData: event.homeData,
          moreExpense: event.moreExpense,
          moreIncome: !more,
          expenseCategories: event.expenseCategories,
          incomeCategories: tempCategory,
        ));
      } else {
        List<String> tempCategory = incomeCategories;
        for (int i = 0; i < Category.incomeCategory.length; i++) {
          if (!tempCategory.contains(Category.incomeCategory[i])) {
            tempCategory.add(Category.incomeCategory[i]);
          }
        }

        emit(HomeLoadedState(
          greeting: event.greeting,
          homeData: event.homeData,
          moreExpense: event.moreExpense,
          moreIncome: !more,
          expenseCategories: event.expenseCategories,
          incomeCategories: tempCategory,
        ));
      }
    });

    on<MECEvent>((event, emit) {
      bool more = event.moreExpense;
      List<ExpenseCategorized> category =
          event.homeData.thisMonthExpenseCategories!;
      List<String> expenseCategories = event.expenseCategories;

      if (more) {
        List<String> tempCategory = category
            .asMap()
            .map((key, value) {
              return MapEntry(key, category[key].category!);
            })
            .values
            .toList();

        emit(HomeLoadedState(
          greeting: event.greeting,
          homeData: event.homeData,
          moreExpense: !more,
          moreIncome: event.moreIncome,
          expenseCategories: tempCategory,
          incomeCategories: event.incomeCategories,
        ));
      } else {
        List<String> tempCategory = expenseCategories;
        for (int i = 0; i < Category.expenseCategory.length; i++) {
          if (!tempCategory.contains(Category.expenseCategory[i])) {
            tempCategory.add(Category.expenseCategory[i]);
          }
        }

        emit(HomeLoadedState(
          greeting: event.greeting,
          homeData: event.homeData,
          moreExpense: !more,
          moreIncome: event.moreIncome,
          expenseCategories: tempCategory,
          incomeCategories: event.incomeCategories,
        ));
      }
    });
  }
}
