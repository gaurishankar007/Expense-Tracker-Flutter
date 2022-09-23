import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class CheckInternet {
  final _connectivity = Connectivity();
  final connectivityStream = StreamController<ConnectivityResult>();

  CheckInternet() {
    _connectivity.onConnectivityChanged.listen((event) {
      connectivityStream.add(event);
    });
  }
}
