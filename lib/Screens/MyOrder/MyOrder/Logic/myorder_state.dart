import 'package:flutter/foundation.dart';
import '../../Model/myorder_entity.dart';

@immutable
abstract class MyorderState {}

class MyorderInitial extends MyorderState {}

class MyorderLoading extends MyorderState {}

class MyorderLoaded extends MyorderState {
  final List<MyorderDataResults> orders;
  final bool hasReachedMax;

  MyorderLoaded({
    required this.orders,
    required this.hasReachedMax,
  });
}

class MyorderError extends MyorderState {
  final String message;

  MyorderError(this.message);
}
