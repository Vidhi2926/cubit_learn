import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'login_state.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart'; // Corrected import

import 'login_repository.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository _loginRepository;
  final InternetConnectionChecker _connectionChecker; // Corrected type

  LoginCubit(this._loginRepository, this._connectionChecker) : super(LoginInitial());

  Future<void> login(String mobile, String password) async {
    emit(LoginLoading());
    print('Login attempt with mobile: $mobile and password: $password'); // Debugging print

    // Check internet connectivity
    final hasConnection = await _connectionChecker.hasConnection;
    if (!hasConnection) {
      emit(LoginFailure("No internet connection"));
      print('No internet connection, emitting LoginFailure state'); // Debugging print
      return;
    }

    try {
      final loginResponse = await _loginRepository.login(mobile: mobile, password: password);
      print('Login response: $loginResponse'); // Debugging print

      if (loginResponse != null) {
        emit(LoginLoaded(loginResponse));
        print('Login successful, emitting LoginLoaded state'); // Debugging print
      } else {
        emit(LoginFailure("Login failed"));
        print('Login failed, emitting LoginFailure state'); // Debugging print
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
      print('Error occurred: $e'); // Debugging print
    }
  }
}
