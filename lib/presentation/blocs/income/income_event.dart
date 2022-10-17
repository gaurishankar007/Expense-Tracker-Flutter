part of 'income_bloc.dart';

abstract class IncomeEvent extends Equatable {
  const IncomeEvent();

  @override
  List<Object> get props => [];
}

class IncomeLoadingEvent extends IncomeEvent {
  final bool internet;

  const IncomeLoadingEvent({
    required this.internet,
  });

  @override
  List<Object> get props => [internet];
}

class IncomeLoadedEvent extends IncomeEvent {
  @override
  List<Object> get props => [];
}

class IncomeLoadedNewEvent extends IncomeEvent {
  final TimePeriod timePeriod;

  const IncomeLoadedNewEvent({
    required this.timePeriod,
  });

  @override
  List<Object> get props => [
        timePeriod,
      ];
}

class IncomeSearchEvent extends IncomeEvent {
  final TimePeriod timePeriod;
  final String startDate;
  final String endDate;

  const IncomeSearchEvent({
    required this.timePeriod,
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object> get props => [
        timePeriod,
        startDate,
        endDate,
      ];
}

class IncomeAddedEvent extends IncomeEvent {
  final TimePeriod timePeriod;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String name;
  final String amount;
  final String category;

  const IncomeAddedEvent({
    required this.timePeriod,
    required this.scaffoldKey,
    required this.name,
    required this.amount,
    required this.category,
  });

  @override
  List<Object> get props => [
        timePeriod,
        scaffoldKey,
        name,
        amount,
        category,
      ];
}

class IncomeRemovedEvent extends IncomeEvent {
  final TimePeriod timePeriod;
  final String id;

  const IncomeRemovedEvent({
    required this.timePeriod,
    required this.id,
  });

  @override
  List<Object> get props => [
        timePeriod,
        id,
      ];
}

class IncomeEditedEvent extends IncomeEvent {
  final TimePeriod timePeriod;
  final IncomeData incomeData;

  const IncomeEditedEvent({
    required this.timePeriod,
    required this.incomeData,
  });

  @override
  List<Object> get props => [
        timePeriod,
      ];
}

class ErrorEvent extends IncomeEvent {
  @override
  List<Object> get props => [];
}
