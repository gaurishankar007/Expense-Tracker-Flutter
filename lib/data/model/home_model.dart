import 'package:json_annotation/json_annotation.dart';

import 'expense_model.dart';
import 'income_model.dart';

part 'home_model.g.dart';

@JsonSerializable()
class HomeData {
  bool? thisMonthView;
  List<int>? expenseDays;
  List<int>? expenseAmounts;
  int? maxExpenseAmount;
  List<ExpenseCategorized>? thisMonthExpenseCategories;
  List<IncomeCategorized>? thisMonthIncomeCategories;
  int? thisMonthExpenseAmount;
  int? thisMonthIncomeAmount;
  int? previousMonthExpenseAmount;
  int? previousMonthIncomeAmount;

  HomeData({
    this.thisMonthView,
    this.expenseDays,
    this.expenseAmounts,
    this.maxExpenseAmount,
    this.thisMonthExpenseCategories,
    this.thisMonthIncomeCategories,
    this.thisMonthExpenseAmount,
    this.thisMonthIncomeAmount,
    this.previousMonthExpenseAmount,
    this.previousMonthIncomeAmount,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) =>
      _$HomeDataFromJson(json);

  Map<String, dynamic> toJson() => _$HomeDataToJson(this);
}
