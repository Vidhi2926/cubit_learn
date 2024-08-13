import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity/connectivity.dart';
import '../../../../connectivity_helper.dart';
import 'login_state.dart';
import 'login_repository.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository _loginRepository;
  final ConnectivityHelper _connectivityHelper;

  LoginCubit(this._loginRepository, InternetConnectionChecker internetConnectionChecker)
      : _connectivityHelper = ConnectivityHelper(
    onConnected: () => _onConnected(),
    onDisconnected: () => _onDisconnected(),
    onFetchOrders: () {}, // No need for this in the login cubit
  ),
        super(LoginInitial()) {
    _connectivityHelper.checkInitialConnectivity(onFetchOrders: () {});
  }

  static void _onConnected() {
    // Optional: Handle any actions you want when the connection is restored
  }

  static void _onDisconnected() {
    // Optional: Handle any actions you want when the connection is lost
  }

  Future<void> login(String mobile, String password) async {
    emit(LoginLoading());

    try {
      final loginResponse = await _loginRepository.login(mobile: mobile, password: password);

      if (loginResponse != null) {
        emit(LoginLoaded(loginResponse));
      } else {
        emit(LoginFailure("Login failed"));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _connectivityHelper.dispose();
    return super.close();
  }
}
