import 'package:cubit_learn/generated/json/base/json_field.dart';
import 'package:cubit_learn/generated/json/otp_entity.g.dart';
import 'dart:convert';
export 'package:cubit_learn/generated/json/otp_entity.g.dart';

@JsonSerializable()
class OtpEntity {
	@JSONField(name: "status_code")
	late String statusCode;
	@JSONField(name: "status_message")
	late String statusMessage;
	late String datetime;
	dynamic data;

	OtpEntity();

	factory OtpEntity.fromJson(Map<String, dynamic> json) => $OtpEntityFromJson(json);

	Map<String, dynamic> toJson() => $OtpEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}