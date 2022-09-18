part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadedState extends HomeState {
  final HomeData homeData;
  final List<String> expenseCategories;
  final List<String> incomeCategories;
  final bool achievementUnlocked;

  const HomeLoadedState({
    required this.homeData,
    required this.expenseCategories,
    required this.incomeCategories,
    required this.achievementUnlocked,
  });

  @override
  List<Object> get props => [homeData];
}
