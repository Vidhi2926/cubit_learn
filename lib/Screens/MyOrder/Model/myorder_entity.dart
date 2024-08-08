import 'package:cubit_learn/generated/json/base/json_field.dart';
import 'package:cubit_learn/generated/json/myorder_entity.g.dart';
import 'dart:convert';
export 'package:cubit_learn/generated/json/myorder_entity.g.dart';

@JsonSerializable()
class MyorderEntity {
	@JSONField(name: "status_code")
	late String statusCode;
	@JSONField(name: "status_message")
	late String statusMessage;
	late String datetime;
	late MyorderData data;

	MyorderEntity();

	factory MyorderEntity.fromJson(Map<String, dynamic> json) => $MyorderEntityFromJson(json);

	Map<String, dynamic> toJson() => $MyorderEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MyorderData {
	late List<MyorderDataResults> results;
	late int rpp;
	@JSONField(name: "current_page")
	late int currentPage;

	MyorderData();

	factory MyorderData.fromJson(Map<String, dynamic> json) => $MyorderDataFromJson(json);

	Map<String, dynamic> toJson() => $MyorderDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MyorderDataResults {
	late String id;
	@JSONField(name: "bill_no")
	late String billNo;
	@JSONField(name: "order_number")
	late String orderNumber;
	@JSONField(name: "order_delivery_datetime")
	late String orderDeliveryDatetime;
	@JSONField(name: "delivery_type")
	late String deliveryType;
	@JSONField(name: "order_status")
	late String orderStatus;
	@JSONField(name: "created_date")
	late String createdDate;
	late int amount;
	@JSONField(name: "delivery_id")
	late int deliveryId;
	@JSONField(name: "order_mode")
	late String orderMode;
	@JSONField(name: "order_status_display_text")
	late String orderStatusDisplayText;
	@JSONField(name: "order_status_display")
	late String orderStatusDisplay;

	MyorderDataResults();

	factory MyorderDataResults.fromJson(Map<String, dynamic> json) => $MyorderDataResultsFromJson(json);

	Map<String, dynamic> toJson() => $MyorderDataResultsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}