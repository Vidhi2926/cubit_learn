import 'package:bloc/bloc.dart';
import 'package:cubit_learn/Screens/SignUp/SignUp/logic/signup_repository.dart';
import 'package:cubit_learn/Screens/SignUp/SignUp/logic/signup_state.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpRepo _signUpRepo;
  final InternetConnectionChecker _connectionChecker;

  // Corrected constructor to accept instances of SignUpRepo and InternetConnectionChecker
  SignUpCubit(this._signUpRepo, this._connectionChecker) : super(SignUpInitial());

  Future<void> onOtpSend({
    required String firstName,
    required String lastName,
    required String phone,
    required String referral,
  }) async {
    final hasConnection = await _connectionChecker.hasConnection;
    if (!hasConnection) {
      emit(SignUpError(error: "No internet connection"));
      print('No internet connection, emitting SignUpError state'); // Debugging print
      return;
    }
    emit(SignUpContinue()); // Show loading state

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
