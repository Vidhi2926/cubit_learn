import '../../../../api/api.dart';
import '../../Model/signup_entity.dart';

class SignUpRepo {
 Api api = Api();



  Future<SignupEntity?> sendOtp({
    required String firstName,
    required String lastName,
    required String phone,
    required String referral,
  }) async {
    try {
      final response = await api.sendRequest.post(
        '/login/signup_sendotp',
        data: {
          "mobile": phone,
          "firstname": firstName,
          "lastname": lastName,
          "referral_code": referral,
          "platform": "android",
          "user_id": "",
          "patient_id": "",
          "device_id": "9348d663fde2493f",
          "accesstoken": "",
          "fcmtoken": "cjGb_15pQCWrrbSqVtu7oV:APA91bEEgVgLOpRKx43ruK4-JI80HGqZ9KUzSwz1zMc8f--rFjyLSl8WyBfL01gNLmhyqkfsF2FWD94CLE-Hfi2q1DMmnOC9apyhF62PH2lqfwussbqfHGnQJX-ODrRk3MU9emOBxTiX",
          "app_version": "33",
          "os": "android",
          "apikey": "adDEWRWEF46546DFDSFsdfsfsdfsdfsl",
        },
      );

      if (response.statusCode == 200) {
        var otpResp = SignupEntity.fromJson(response.data);

        if (otpResp.statusCode == '1') {
          return otpResp;
        } else {
          print('OTP sending failed: ${otpResp.statusMessage}');
          return otpResp;
        }
      } else {
        print('HTTP error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('OTP sending failed: $e');
      return null;
    }
  }

  Future<SignupEntity?> sendSignDetails({
    required String firstName,
    required String lastName,
    required String phone,
    required String referral,
    required String password,
    required String otp,
    required String pinCode,
  }) async {
    try {
      final response = await api.sendRequest.post(
        '/login/signup',
        data: {
          "mobile": phone,
          "firstname": firstName,
          "lastname": lastName,
          "password": password,
          "otp": otp,
          "pincode": pinCode,
          "referral_code": referral,
          "platform": "android",
          "utm_source": "C00NC",
          "utm_medium": "android",
          "utm_campaign": "white_label",
          "user_id": "",
          "patient_id": "",
          "device_id": "9348d663fde2493f",
         // "accesstoken": "",
          "fcmtoken": "cjGb_15pQCWrrbSqVtu7oV:APA91bEEgVgLOpRKx43ruK4-JI80HGqZ9KUzSwz1zMc8f--rFjyLSl8WyBfL01gNLmhyqkfsF2FWD94CLE-Hfi2q1DMmnOC9apyhF62PH2lqfwussbqfHGnQJX-ODrRk3MU9emOBxTiX",
          "app_version": "33",
          "os": "android",
          "apikey": "adDEWRWEF46546DFDSFsdfsfsdfsdfsl",
        },
      );

      if (response.statusCode == 200) {
        var signUpResp = SignupEntity.fromJson(response.data);

        if (signUpResp.statusCode == '1') {

          return signUpResp;
        } else {
          print('Sign-up failed: ${signUpResp.statusMessage}');
          return null;
        }
      } else {
        print('HTTP error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Sign-up failed: $e');
      return null;
    }
  }
}
