import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/config/themes/constant.dart';
import 'package:expense_tracker/data/model/income_model.dart';
import 'package:expense_tracker/data/remote/income_http.dart';
import 'package:expense_tracker/presentation/widgets/message.dart';
import 'package:flutter/material.dart';

part 'income_event.dart';
part 'income_state.dart';

enum TimePeriod {
  today,
  thisWeek,
  thisMonth,
  searching,
}

class IncomeBloc extends Bloc<IncomeEvent, IncomeState> {
  IncomeDWM? incomeDWM;

  IncomeBloc() : super(IncomeLoadingState(internet: true)) {
    on<IncomeLoadingEvent>((event, emit) {
      emit(IncomeLoadingState(internet: event.internet));
    });

    on<IncomeLoadedEvent>((event, emit) async {
      emit(IncomeLoadingState(internet: true));

      try {
        incomeDWM ??= await IncomeHttp().getIncomeDWM();

        emit(IncomeLoadedState(
          timePeriod: TimePeriod.today,
          profilePicture: incomeDWM!.profilePicture!,
          firstIncomeDate: incomeDWM!.firstIncomeDate!,
          incomes: incomeDWM!.todayIncomes!,
          incomeAmount: incomeDWM!.todayIncomeAmount!,
          incomeCategories: incomeDWM!.todayIncomeCategories!,
        ));
      } catch (error) {
        if (error.toString().split(":").first == "SocketException") {
          emit(IncomeLoadingState(internet: false));
        } else {
          emit(ErrorState());
        }
      }
    });

    on<IncomeLoadedNewEvent>((event, emit) {
      late List<IncomeData> incomes;
      late int incomeAmount;
      late List<IncomeCategorized> incomeCategories;

      if (event.timePeriod == TimePeriod.today) {
        incomes = incomeDWM!.todayIncomes!;
        incomeAmount = incomeDWM!.todayIncomeAmount!;
        incomeCategories = incomeDWM!.todayIncomeCategories!;
      } else if (event.timePeriod == TimePeriod.thisWeek) {
        incomes = incomeDWM!.thisWeekIncomes!;
        incomeAmount = incomeDWM!.thisWeekIncomeAmount!;
        incomeCategories = incomeDWM!.thisWeekIncomeCategories!;
      } else if (event.timePeriod == TimePeriod.thisMonth) {
        incomes = incomeDWM!.thisMonthIncomes!;
        incomeAmount = incomeDWM!.thisMonthIncomeAmount!;
        incomeCategories = incomeDWM!.thisMonthIncomeCategories!;
      } else {
        incomes = [];
        incomeAmount = 0;
        incomeCategories = [];
      }

      emit(IncomeLoadedState(
        timePeriod: event.timePeriod,
        profilePicture: incomeDWM!.profilePicture!,
        firstIncomeDate: incomeDWM!.firstIncomeDate!,
        incomes: incomes,
        incomeAmount: incomeAmount,
        incomeCategories: incomeCategories,
      ));
    });

    on<IncomeSearchEvent>((event, emit) async {
      try {
        final IncomeSpecific incomeSpecific = await IncomeHttp()
            .getIncomeSpecific(event.startDate, event.endDate);

        emit(IncomeLoadedState(
          timePeriod: TimePeriod.searching,
          profilePicture: incomeDWM!.profilePicture!,
          firstIncomeDate: incomeDWM!.firstIncomeDate!,
          incomes: incomeSpecific.incomes!,
          incomeAmount: incomeSpecific.incomeAmount!,
          incomeCategories: incomeSpecific.incomeCategories!,
        ));
      } catch (error) {
        if (error.toString().split(":").first == "SocketException") {
          emit(IncomeLoadingState(internet: false));
        } else {
          emit(ErrorState());
        }
      }
    });

    on<IncomeAddedEvent>((event, emit) async {
      final resData = await IncomeHttp().addIncome(
        IncomeData(
          name: event.name,
          amount: int.parse(event.amount),
          category: event.category,
        ),
      );

      if (resData["statusCode"] == 201) {
        incomeDWM = await IncomeHttp().getIncomeDWM();

        TimePeriod timePeriod = event.timePeriod;
        late List<IncomeData> incomes;
        late int incomeAmount;
        late List<IncomeCategorized> incomeCategories;

        if (timePeriod == TimePeriod.today) {
          incomes = incomeDWM!.todayIncomes!;
          incomeAmount = incomeDWM!.todayIncomeAmount!;
          incomeCategories = incomeDWM!.todayIncomeCategories!;
        } else if (timePeriod == TimePeriod.thisWeek) {
          incomes = incomeDWM!.thisWeekIncomes!;
          incomeAmount = incomeDWM!.thisWeekIncomeAmount!;
          incomeCategories = incomeDWM!.thisWeekIncomeCategories!;
        } else if (timePeriod == TimePeriod.thisMonth) {
          incomes = incomeDWM!.thisMonthIncomes!;
          incomeAmount = incomeDWM!.thisMonthIncomeAmount!;
          incomeCategories = incomeDWM!.thisMonthIncomeCategories!;
        } else {
          incomes = [];
          incomeAmount = 0;
          incomeCategories = [];
        }

        emit(IncomeLoadedState(
          timePeriod: timePeriod,
          profilePicture: incomeDWM!.profilePicture!,
          firstIncomeDate: incomeDWM!.firstIncomeDate!,
          incomes: incomes,
          incomeAmount: incomeAmount,
          incomeCategories: incomeCategories,
        ));

        Message(
          message: resData["body"]["resM"],
          time: 3,
          bgColor: Colors.green,
          textColor: AppColor.onPrimary,
        ).showMessage;

        if (resData["body"]["achievementUnlocked"]) {
          showDialog(
            context: event.scaffoldKey.currentContext!,
            builder: (builder) => SimpleDialog(
              backgroundColor: AppColor.backgroundLight,
              titlePadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.all(10),
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        fit: BoxFit.fitWidth,
                        image: AssetImage(
                          "image/Congratulation.png",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "New Achievement Unlocked.",
                      style: TextStyle(
                        color: AppColor.text,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        minimumSize: Size.zero,
                        padding: EdgeInsets.all(8),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(event.scaffoldKey.currentContext!);
                        Navigator.pushNamed(
                          event.scaffoldKey.currentContext!,
                          "/result",
                        );
                      },
                      child: Text("Check Out"),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      } else {
        Message(
          message: resData["body"]["resM"],
          time: 3,
          bgColor: Colors.red,
          textColor: AppColor.onPrimary,
        ).showMessage;
      }
    });

    on<IncomeRemovedEvent>((event, emit) async {
      final resData = await IncomeHttp().removeIncome(event.id);

      incomeDWM = await IncomeHttp().getIncomeDWM();

      TimePeriod timePeriod = event.timePeriod;
      late List<IncomeData> incomes;
      late int incomeAmount;
      late List<IncomeCategorized> incomeCategories;

      if (timePeriod == TimePeriod.today) {
        incomes = incomeDWM!.todayIncomes!;
        incomeAmount = incomeDWM!.todayIncomeAmount!;
        incomeCategories = incomeDWM!.todayIncomeCategories!;
      } else if (timePeriod == TimePeriod.thisWeek) {
        incomes = incomeDWM!.thisWeekIncomes!;
        incomeAmount = incomeDWM!.thisWeekIncomeAmount!;
        incomeCategories = incomeDWM!.thisWeekIncomeCategories!;
      } else if (timePeriod == TimePeriod.thisMonth) {
        incomes = incomeDWM!.thisMonthIncomes!;
        incomeAmount = incomeDWM!.thisMonthIncomeAmount!;
        incomeCategories = incomeDWM!.thisMonthIncomeCategories!;
      } else {
        incomes = [];
        incomeAmount = 0;
        incomeCategories = [];
      }

      emit(IncomeLoadedState(
        timePeriod: timePeriod,
        profilePicture: incomeDWM!.profilePicture!,
        firstIncomeDate: incomeDWM!.firstIncomeDate!,
        incomes: incomes,
        incomeAmount: incomeAmount,
        incomeCategories: incomeCategories,
      ));

      Message(
        message: resData["resM"],
        time: 3,
        bgColor: AppColor.primary,
        textColor: AppColor.onPrimary,
      ).showMessage;
    });

    on<IncomeEditedEvent>((event, emit) async {
      final resData = await IncomeHttp().editIncome(event.incomeData);

      if (resData["statusCode"] == 200) {
        incomeDWM = await IncomeHttp().getIncomeDWM();

        TimePeriod timePeriod = event.timePeriod;
        late List<IncomeData> incomes;
        late int incomeAmount;
        late List<IncomeCategorized> incomeCategories;

        if (timePeriod == TimePeriod.today) {
          incomes = incomeDWM!.todayIncomes!;
          incomeAmount = incomeDWM!.todayIncomeAmount!;
          incomeCategories = incomeDWM!.todayIncomeCategories!;
        } else if (timePeriod == TimePeriod.thisWeek) {
          incomes = incomeDWM!.thisWeekIncomes!;
          incomeAmount = incomeDWM!.thisWeekIncomeAmount!;
          incomeCategories = incomeDWM!.thisWeekIncomeCategories!;
        } else if (timePeriod == TimePeriod.thisMonth) {
          incomes = incomeDWM!.thisMonthIncomes!;
          incomeAmount = incomeDWM!.thisMonthIncomeAmount!;
          incomeCategories = incomeDWM!.thisMonthIncomeCategories!;
        } else {
          incomes = [];
          incomeAmount = 0;
          incomeCategories = [];
        }

        emit(IncomeLoadedState(
          timePeriod: timePeriod,
          profilePicture: incomeDWM!.profilePicture!,
          firstIncomeDate: incomeDWM!.firstIncomeDate!,
          incomes: incomes,
          incomeAmount: incomeAmount,
          incomeCategories: incomeCategories,
        ));

        Message(
          message: resData["body"]["resM"],
          time: 3,
          bgColor: Colors.green,
          textColor: AppColor.onPrimary,
        ).showMessage;
      } else {
        Message(
          message: resData["body"]["resM"],
          time: 3,
          bgColor: Colors.red,
          textColor: AppColor.onPrimary,
        ).showMessage;
      }
    });
  }
}
