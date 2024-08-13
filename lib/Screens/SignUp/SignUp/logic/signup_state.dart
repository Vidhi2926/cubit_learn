class SignUpState {}

class NoInternetState extends SignUpState {}

class InternetRestoredState extends SignUpState {}

class RefreshingState extends SignUpState{}

final class SignUpInitial extends SignUpState {}

final class SignUpContinue extends SignUpState {}

final class SignUpOtpSend extends SignUpState {}

final class SignUpSuccess extends SignUpState {}

final class SignUpError extends SignUpState {
  String error;

  SignUpError({required this.error});
}
