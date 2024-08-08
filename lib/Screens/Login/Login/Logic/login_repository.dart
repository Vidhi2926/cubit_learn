import 'package:cubit_learn/api/api.dart';

import '../../Model/login_entity.dart';

class LoginRepository {
 Api api = Api();
  Future<LoginEntity?> login({
    required String mobile,
    required String password,
  }) async {
    try {
      final response = await api.sendRequest.post(
        '/login',
        data: {
          'mobile': mobile,
          'password': password,
          'platform': 'android',
          'user_id': '',
          'patient_id': '',
          'device_id': '9348d663fde2493f',
          'accesstoken': '',
          'fcmtoken': 'cjGb_15pQCWrrbSqVtu7oV:APA91bEEgVgLOpRKx43ruK4-JI80HGqZ9KUzSwz1zMc8f--rFjyLSl8WyBfL01gNLmhyqkfsF2FWD94CLE-Hfi2q1DMmnOC9apyhF62PH2lqfwussbqfHGnQJX-ODrRk3MU9emOBxTiX',
          'app_version': '33',
          'os': 'android',
          'apikey': 'adDEWRWEF46546DFDSFsdfsfsdfsdfsl',

        },
      );

      if (response.statusCode == 200) {
        var loginResp = LoginEntity.fromJson(response.data);

        if (loginResp.statusCode == '1') {

          return loginResp;
        } else {
          print('Login failed: ${loginResp.statusMessage}');
          return null;
        }
      } else {
        print('HTTP error: ${response.statusCode} ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      print('Login failed: $e');
      return null;
    }
  }
}
