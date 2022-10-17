import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

import '../../../core/resources/internet_check.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  InternetBloc() : super(InternetState(connected: true)) {
    CheckInternet().connectivityStream.stream.listen((event) {
      if (event == ConnectivityResult.none) {
        add(InternetEvent(connected: false));
      } else {
        add(InternetEvent(connected: true));
      }
    });

    on<InternetEvent>((event, emit) {
      emit(InternetState(connected: event.connected));
    });
  }
}
