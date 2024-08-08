import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../Model/myorder_entity.dart';
import 'myorder_repo.dart';
import 'myorder_state.dart';

class MyorderCubit extends Cubit<MyorderState> {
  List<MyorderDataResults> _orders = [];
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isLoading = false;
  final MyorderRepo orderRepo;
  String? billNo;
  final InternetConnectionChecker _connectionChecker;
  StreamSubscription? _connectionSubscription;

  MyorderCubit(this.orderRepo, this._connectionChecker) : super(MyorderInitial()) {
    _monitorConnection();
  }

  Future<void> _monitorConnection() async {
    _connectionSubscription = _connectionChecker.onStatusChange.listen((status) {
      final hasConnection = status == InternetConnectionStatus.connected;
      if (!hasConnection) {
        emit(MyorderError("No internet connection"));
      }
    });
  }

  Future<void> fetchOrders({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _hasMore = true;
      _orders.clear();
      emit(MyorderLoading());
    } else {
      if (_isLoading || !_hasMore) return;
      _isLoading = true;
    }

    final hasConnection = await _connectionChecker.hasConnection;
    if (!hasConnection) {
      emit(MyorderError("No internet connection"));
      _isLoading = false;
      return;
    }

    try {
      final response = await orderRepo.fetchOrders(_currentPage, billNo: billNo ?? '');

      if (response != null) {
        final newOrders = response.data.results;
        _orders.addAll(newOrders);

        _hasMore = newOrders.length == 20;

        emit(MyorderLoaded(
          orders: _orders,
          hasReachedMax: !_hasMore,
        ));

        if (refresh) {
          _currentPage = 2;
        } else {
          _currentPage++;
        }
      } else {
        emit(MyorderError('Failed to fetch orders. Response was null.'));
      }
    } catch (e) {
      emit(MyorderError('Failed to fetch orders: ${e.toString()}'));
    } finally {
      _isLoading = false;
    }
  }

  void applyFilter({required String billNo}) {
    this.billNo = billNo;
    fetchOrders(refresh: true);
  }

  @override
  Future<void> close() {
    _connectionSubscription?.cancel();
    return super.close();
  }
}
