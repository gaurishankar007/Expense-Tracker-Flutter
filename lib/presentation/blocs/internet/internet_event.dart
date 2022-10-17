part of 'internet_bloc.dart';

class InternetEvent extends Equatable {
  final bool connected;
  const InternetEvent({
    required this.connected,
  });

  @override
  List<Object> get props => [connected];
}