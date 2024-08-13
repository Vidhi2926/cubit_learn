import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConnectivityHelper {
  late final StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ConnectivityResult _previousConnectivityResult = ConnectivityResult.none;
  bool _hasShownNoInternet = false;
  bool _isLoading = false;
  bool _hasMore = true;

  ConnectivityHelper({
    required Function onConnected,
    required Function onDisconnected,
    required Function onFetchOrders,
  }) {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      if (result != _previousConnectivityResult) {
        if (result != ConnectivityResult.none) {
          if (_hasShownNoInternet) {
            Fluttertoast.showToast(
              msg: "Welcome back, you regained your connection",
              backgroundColor: Colors.green,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
            );
            _hasShownNoInternet = false; // Reset the flag
          }
          // Trigger fetch when network is restored
          if (!_isLoading && _hasMore) {
            onFetchOrders();
          }
          onConnected();
        } else {
          if (!_hasShownNoInternet) {
            Fluttertoast.showToast(
              msg: "No internet connection",
              backgroundColor: Colors.red,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
            );
            _hasShownNoInternet = true; // Set the flag to true
          }
          onDisconnected();
        }
        _previousConnectivityResult = result; // Update previous result
      }
    });
  }

  Future<void> checkInitialConnectivity({
    required Function onFetchOrders,
  }) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      onFetchOrders();
    } else {
      Fluttertoast.showToast(
        msg: "No internet connection",
        backgroundColor: Colors.red,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
      _hasShownNoInternet = true;
    }
  }

  void dispose() {
    _connectivitySubscription.cancel();
  }
}
