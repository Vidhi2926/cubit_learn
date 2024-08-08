import 'package:cubit_learn/generated/json/base/json_convert_content.dart';
import 'package:cubit_learn/Screens/SignUp/Model/signup_entity.dart';

SignupEntity $SignupEntityFromJson(Map<String, dynamic> json) {
  final SignupEntity signupEntity = SignupEntity();
  final String? statusCode = jsonConvert.convert<String>(json['status_code']);
  if (statusCode != null) {
    signupEntity.statusCode = statusCode;
  }
  final String? statusMessage = jsonConvert.convert<String>(
      json['status_message']);
  if (statusMessage != null) {
    signupEntity.statusMessage = statusMessage;
  }
  final String? datetime = jsonConvert.convert<String>(json['datetime']);
  if (datetime != null) {
    signupEntity.datetime = datetime;
  }
  final dynamic data = json['data'];
  if (data != null) {
    signupEntity.data = data;
  }
  return signupEntity;
}

Map<String, dynamic> $SignupEntityToJson(SignupEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status_code'] = entity.statusCode;
  data['status_message'] = entity.statusMessage;
  data['datetime'] = entity.datetime;
  data['data'] = entity.data;
  return data;
}

extension SignupEntityExtension on SignupEntity {
  SignupEntity copyWith({
    String? statusCode,
    String? statusMessage,
    String? datetime,
    dynamic data,
  }) {
    return SignupEntity()
      ..statusCode = statusCode ?? this.statusCode
      ..statusMessage = statusMessage ?? this.statusMessage
      ..datetime = datetime ?? this.datetime
      ..data = data ?? this.data;
  }
}