part of 'internet_bloc.dart';

class InternetState extends Equatable {
  final bool connected;
  const InternetState({
    required this.connected,
  });

  @override
  List<Object> get props => [connected];
}
