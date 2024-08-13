import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../../../connectivity_helper.dart';
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
  late final ConnectivityHelper _connectivityHelper;

  MyorderCubit(this.orderRepo) : super(MyorderInitial()) {
    _connectivityHelper = ConnectivityHelper(
      onConnected: () {},
      onDisconnected: () {},
      onFetchOrders: fetchOrders,
    );
    _connectivityHelper.checkInitialConnectivity(onFetchOrders: fetchOrders);
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
        _currentPage = refresh ? 2 : _currentPage + 1;
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
    _connectivityHelper.dispose();
    return super.close();
  }
}
