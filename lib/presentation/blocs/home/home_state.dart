part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadedState extends HomeState {
  final String greeting;
  final HomeData homeData;
  final bool moreExpense;
  final bool moreIncome;
  final List<String> expenseCategories;
  final List<String> incomeCategories;

  const HomeLoadedState({
    required this.greeting,
    required this.homeData,
    required this.moreExpense,
    required this.moreIncome,
    required this.expenseCategories,
    required this.incomeCategories,
  });

  @override
  List<Object> get props => [
        greeting,
        homeData,
        moreExpense,
        moreIncome,
        expenseCategories,
        incomeCategories,
      ];
}

class NoInternetState extends HomeState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends HomeState {
  @override
  List<Object?> get props => [];
}
