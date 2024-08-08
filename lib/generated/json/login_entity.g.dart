import 'package:cubit_learn/generated/json/base/json_convert_content.dart';
import 'package:cubit_learn/Screens/Login/Model/login_entity.dart';

LoginEntity $LoginEntityFromJson(Map<String, dynamic> json) {
  final LoginEntity loginEntity = LoginEntity();
  final String? statusCode = jsonConvert.convert<String>(json['status_code']);
  if (statusCode != null) {
    loginEntity.statusCode = statusCode;
  }
  final String? statusMessage = jsonConvert.convert<String>(
      json['status_message']);
  if (statusMessage != null) {
    loginEntity.statusMessage = statusMessage;
  }
  final String? datetime = jsonConvert.convert<String>(json['datetime']);
  if (datetime != null) {
    loginEntity.datetime = datetime;
  }
  final dynamic data = json['data'];
  if (data != null) {
    loginEntity.data = data;
  }
  return loginEntity;
}

Map<String, dynamic> $LoginEntityToJson(LoginEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status_code'] = entity.statusCode;
  data['status_message'] = entity.statusMessage;
  data['datetime'] = entity.datetime;
  data['data'] = entity.data;
  return data;
}

extension LoginEntityExtension on LoginEntity {
  LoginEntity copyWith({
    String? statusCode,
    String? statusMessage,
    String? datetime,
    dynamic data,
  }) {
    return LoginEntity()
      ..statusCode = statusCode ?? this.statusCode
      ..statusMessage = statusMessage ?? this.statusMessage
      ..datetime = datetime ?? this.datetime
      ..data = data ?? this.data;
  }
}