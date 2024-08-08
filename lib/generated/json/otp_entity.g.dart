import 'package:cubit_learn/generated/json/base/json_convert_content.dart';
import 'package:cubit_learn/Screens/SignUp/Model/otp_entity.dart';

OtpEntity $OtpEntityFromJson(Map<String, dynamic> json) {
  final OtpEntity otpEntity = OtpEntity();
  final String? statusCode = jsonConvert.convert<String>(json['status_code']);
  if (statusCode != null) {
    otpEntity.statusCode = statusCode;
  }
  final String? statusMessage = jsonConvert.convert<String>(
      json['status_message']);
  if (statusMessage != null) {
    otpEntity.statusMessage = statusMessage;
  }
  final String? datetime = jsonConvert.convert<String>(json['datetime']);
  if (datetime != null) {
    otpEntity.datetime = datetime;
  }
  final dynamic data = json['data'];
  if (data != null) {
    otpEntity.data = data;
  }
  return otpEntity;
}

Map<String, dynamic> $OtpEntityToJson(OtpEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status_code'] = entity.statusCode;
  data['status_message'] = entity.statusMessage;
  data['datetime'] = entity.datetime;
  data['data'] = entity.data;
  return data;
}

extension OtpEntityExtension on OtpEntity {
  OtpEntity copyWith({
    String? statusCode,
    String? statusMessage,
    String? datetime,
    dynamic data,
  }) {
    return OtpEntity()
      ..statusCode = statusCode ?? this.statusCode
      ..statusMessage = statusMessage ?? this.statusMessage
      ..datetime = datetime ?? this.datetime
      ..data = data ?? this.data;
  }
}