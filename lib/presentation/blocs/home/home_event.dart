part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeLoadedEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class NoInternetEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class ErrorEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class MICEvent extends HomeEvent {
  final String greeting;
  final HomeData homeData;
  final bool moreExpense;
  final bool moreIncome;
  final List<String> incomeCategories;
  final List<String> expenseCategories;

  const MICEvent({
    required this.greeting,
    required this.homeData,
    required this.moreExpense,
    required this.moreIncome,
    required this.incomeCategories,
    required this.expenseCategories,
  });

  @override
  List<Object> get props => [];
}

class MECEvent extends HomeEvent {
  final String greeting;
  final HomeData homeData;
  final bool moreExpense;
  final bool moreIncome;
  final List<String> incomeCategories;
  final List<String> expenseCategories;

  const MECEvent({
    required this.greeting,
    required this.homeData,
    required this.moreExpense,
    required this.moreIncome,
    required this.incomeCategories,
    required this.expenseCategories,
  });

  @override
  List<Object> get props => [];
}
