import 'package:bloc/bloc.dart';
import 'package:cubit_learn/Screens/SignUp/SignUp/logic/signup_repository.dart';
import 'package:cubit_learn/Screens/SignUp/SignUp/logic/signup_state.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpRepo _signUpRepo;
  final InternetConnectionChecker _connectionChecker;
  bool _wasDisconnected = false;

  // Constructor accepting SignUpRepo and initializing connection monitoring
  SignUpCubit(this._signUpRepo, this._connectionChecker) : super(SignUpInitial()) {
    _monitorConnection();
  }

  // Method to monitor internet connection status
  void _monitorConnection() {
    _connectionChecker.onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.disconnected) {
        _wasDisconnected = true;
        emit(NoInternetState());
      } else if (status == InternetConnectionStatus.connected && _wasDisconnected) {
        _wasDisconnected = false;
        emit(InternetRestoredState());
      }
    });
  }

  // Method to handle OTP sending with internet connection check
  Future<void> onOtpSend({
    required String firstName,
    required String lastName,
    required String phone,
    required String referral,
  }) async {
    emit(SignUpContinue()); // Show loading state

    final hasConnection = await _connectionChecker.hasConnection;
    if (!hasConnection) {
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

    final hasConnection = await _connectionChecker.hasConnection;
    if (!hasConnection) {
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
}
