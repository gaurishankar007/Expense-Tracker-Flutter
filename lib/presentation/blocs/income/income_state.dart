part of 'income_bloc.dart';

abstract class IncomeState extends Equatable {
  const IncomeState();

  @override
  List<Object> get props => [];
}

class IncomeLoadingState extends IncomeState {
  final bool internet;

  const IncomeLoadingState({
    required this.internet,
  });

  @override
  List<Object> get props => [internet];
}

class IncomeLoadedState extends IncomeState {
  final TimePeriod timePeriod;
  final String profilePicture;
  final String firstIncomeDate;
  final List<IncomeData> incomes;
  final int incomeAmount;
  final List<IncomeCategorized> incomeCategories;

  const IncomeLoadedState({
    required this.timePeriod,
    required this.profilePicture,
    required this.firstIncomeDate,
    required this.incomes,
    required this.incomeAmount,
    required this.incomeCategories,
  });

  @override
  List<Object> get props => [
        timePeriod,
        profilePicture,
        firstIncomeDate,
        incomes,
        incomeAmount,
        incomeCategories,
      ];
}

class ErrorState extends IncomeState {
  @override
  List<Object> get props => [];
}
