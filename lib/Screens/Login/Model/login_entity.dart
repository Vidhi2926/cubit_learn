import 'package:cubit_learn/generated/json/base/json_field.dart';
import 'package:cubit_learn/generated/json/login_entity.g.dart';
import 'dart:convert';
export 'package:cubit_learn/generated/json/login_entity.g.dart';

@JsonSerializable()
class LoginEntity {
	@JSONField(name: "status_code")
	late String statusCode;
	@JSONField(name: "status_message")
	late String statusMessage;
	late String datetime;
	dynamic data;

	LoginEntity();

	factory LoginEntity.fromJson(Map<String, dynamic> json) => $LoginEntityFromJson(json);

	Map<String, dynamic> toJson() => $LoginEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}