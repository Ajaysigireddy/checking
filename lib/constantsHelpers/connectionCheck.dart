import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class ConnectivityService extends ChangeNotifier {
  bool _hasConnection = true;
  bool get hasConnection => _hasConnection;

  ConnectivityService() {
    _initConnectivity();
    Connectivity().onConnectivityChanged.listen((result) {
      _hasConnection = result != ConnectivityResult.none;
      notifyListeners();
    });
  }

  Future<void> _initConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    _hasConnection = result != ConnectivityResult.none;
    notifyListeners();
  }

  // Public method to retry connectivity check
  void retryConnectivity() {
    _initConnectivity();
  }
}