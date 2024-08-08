import 'package:cubit_learn/generated/json/base/json_field.dart';
import 'package:cubit_learn/generated/json/signup_entity.g.dart';
import 'dart:convert';
export 'package:cubit_learn/generated/json/signup_entity.g.dart';

@JsonSerializable()
class SignupEntity {
	@JSONField(name: "status_code")
	late String statusCode;
	@JSONField(name: "status_message")
	late String statusMessage;
	late String datetime;
	dynamic data;

	SignupEntity();

	factory SignupEntity.fromJson(Map<String, dynamic> json) => $SignupEntityFromJson(json);

	Map<String, dynamic> toJson() => $SignupEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}