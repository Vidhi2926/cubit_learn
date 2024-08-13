import 'package:bloc/bloc.dart';
import 'package:cubit_learn/Screens/SignUp/SignUp/logic/signup_repository.dart';
import 'package:cubit_learn/Screens/SignUp/SignUp/logic/signup_state.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../connectivity_helper.dart';

// SignUpCubit class using ConnectivityHelper
class SignUpCubit extends Cubit<SignUpState> {
  final SignUpRepo _signUpRepo;
  late final ConnectivityHelper _connectivityHelper;

  // Constructor accepting SignUpRepo and initializing ConnectivityHelper
  SignUpCubit(this._signUpRepo, InternetConnectionChecker ) : super(SignUpInitial()) {
    _connectivityHelper = ConnectivityHelper(
      onConnected: _onConnected,
      onDisconnected: _onDisconnected,
      onFetchOrders: _onFetchOrders, // Replace with appropriate function if needed
    );
    _checkInitialConnectivity();
  }

  // Method to handle internet connection restored
  void _onConnected() {
    // Optionally handle actions when connection is restored
  }

  // Method to handle internet connection lost
  void _onDisconnected() {
    emit(NoInternetState());
  }

  // Placeholder for a function to be called when checking initial connectivity
  void _onFetchOrders() {
    // Replace with actual functionality if needed
  }

  // Method to check initial connectivity
  void _checkInitialConnectivity() async {
    await _connectivityHelper.checkInitialConnectivity(onFetchOrders: _onFetchOrders);
  }

  // Method to handle OTP sending with internet connection check
  Future<void> onOtpSend({
    required String firstName,
    required String lastName,
    required String phone,
    required String referral,
  }) async {
    emit(SignUpContinue()); // Show loading state

    final isConnected = await _connectivityHelper.isConnected();
    if (!isConnected) {
      emit(SignUpError(error: "No internet connection"));
      return;
    }

    final result = await _signUpRepo.sendOtp(
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      referral: referral,
    );

    if (result != null && result.statusCode == '1') {
      emit(SignUpOtpSend()); // Emit success state for OTP sent
    } else {
      final errorMessage = result?.statusMessage ?? 'Failed to send OTP';
      emit(SignUpError(error: errorMessage));
    }
  }

  // Method to handle sign-up submission with internet connection check
  Future<void> onSignUpSubmit({
    required String firstName,
    required String lastName,
    required String phone,
    required String referral,
    required String password,
    required String otp,
    required String pinCode,
  }) async {
    emit(SignUpContinue()); // Show loading state

    final isConnected = await _connectivityHelper.isConnected();
    if (!isConnected) {
      emit(SignUpError(error: "No internet connection"));
      return;
    }

    final result = await _signUpRepo.sendSignDetails(
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      referral: referral,
      password: password,
      otp: otp,
      pinCode: pinCode,
    );

    if (result != null && result.statusCode == '1') {
      emit(SignUpSuccess()); // Emit success state for sign up
    } else {
      final errorMessage = result?.statusMessage ?? 'Failed to sign up';
      emit(SignUpError(error: errorMessage));
    }
  }

  @override
  Future<void> close() {
    _connectivityHelper.dispose();
    return super.close();
  }
}