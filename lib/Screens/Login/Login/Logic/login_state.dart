import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../Model/login_entity.dart';

@immutable
abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}
class ConnectivityConnected extends LoginState {}

class ConnectivityDisconnected extends LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final LoginEntity loginData;
  final bool hasMore;

  LoginLoaded(this.loginData, {this.hasMore = false});

  @override
  List<Object> get props => [loginData, hasMore];
}

class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
