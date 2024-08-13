import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConnectivityHelper {
  late final Stream<ConnectivityResult> connectivityStream;
  bool _hasShownNoInternet = false;

  ConnectivityHelper({
    required Function onConnected,
    required Function onDisconnected,
    required Function onFetchOrders,
  }) {
    connectivityStream = Connectivity().onConnectivityChanged;
    connectivityStream.listen((result) {
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
        onFetchOrders();
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

  Future<bool> isConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  void dispose() {
    // Handle any necessary cleanup here
  }
}
