import 'package:cubit_learn/generated/json/base/json_convert_content.dart';
import 'package:cubit_learn/Screens/MyOrder/Model/myorder_entity.dart';

MyorderEntity $MyorderEntityFromJson(Map<String, dynamic> json) {
  final MyorderEntity myorderEntity = MyorderEntity();
  final String? statusCode = jsonConvert.convert<String>(json['status_code']);
  if (statusCode != null) {
    myorderEntity.statusCode = statusCode;
  }
  final String? statusMessage = jsonConvert.convert<String>(
      json['status_message']);
  if (statusMessage != null) {
    myorderEntity.statusMessage = statusMessage;
  }
  final String? datetime = jsonConvert.convert<String>(json['datetime']);
  if (datetime != null) {
    myorderEntity.datetime = datetime;
  }
  final MyorderData? data = jsonConvert.convert<MyorderData>(json['data']);
  if (data != null) {
    myorderEntity.data = data;
  }
  return myorderEntity;
}

Map<String, dynamic> $MyorderEntityToJson(MyorderEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status_code'] = entity.statusCode;
  data['status_message'] = entity.statusMessage;
  data['datetime'] = entity.datetime;
  data['data'] = entity.data.toJson();
  return data;
}

extension MyorderEntityExtension on MyorderEntity {
  MyorderEntity copyWith({
    String? statusCode,
    String? statusMessage,
    String? datetime,
    MyorderData? data,
  }) {
    return MyorderEntity()
      ..statusCode = statusCode ?? this.statusCode
      ..statusMessage = statusMessage ?? this.statusMessage
      ..datetime = datetime ?? this.datetime
      ..data = data ?? this.data;
  }
}

MyorderData $MyorderDataFromJson(Map<String, dynamic> json) {
  final MyorderData myorderData = MyorderData();
  final List<MyorderDataResults>? results = (json['results'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<MyorderDataResults>(e) as MyorderDataResults)
      .toList();
  if (results != null) {
    myorderData.results = results;
  }
  final int? rpp = jsonConvert.convert<int>(json['rpp']);
  if (rpp != null) {
    myorderData.rpp = rpp;
  }
  final int? currentPage = jsonConvert.convert<int>(json['current_page']);
  if (currentPage != null) {
    myorderData.currentPage = currentPage;
  }
  return myorderData;
}

Map<String, dynamic> $MyorderDataToJson(MyorderData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['results'] = entity.results.map((v) => v.toJson()).toList();
  data['rpp'] = entity.rpp;
  data['current_page'] = entity.currentPage;
  return data;
}

extension MyorderDataExtension on MyorderData {
  MyorderData copyWith({
    List<MyorderDataResults>? results,
    int? rpp,
    int? currentPage,
  }) {
    return MyorderData()
      ..results = results ?? this.results
      ..rpp = rpp ?? this.rpp
      ..currentPage = currentPage ?? this.currentPage;
  }
}

MyorderDataResults $MyorderDataResultsFromJson(Map<String, dynamic> json) {
  final MyorderDataResults myorderDataResults = MyorderDataResults();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    myorderDataResults.id = id;
  }
  final String? billNo = jsonConvert.convert<String>(json['bill_no']);
  if (billNo != null) {
    myorderDataResults.billNo = billNo;
  }
  final String? orderNumber = jsonConvert.convert<String>(json['order_number']);
  if (orderNumber != null) {
    myorderDataResults.orderNumber = orderNumber;
  }
  final String? orderDeliveryDatetime = jsonConvert.convert<String>(
      json['order_delivery_datetime']);
  if (orderDeliveryDatetime != null) {
    myorderDataResults.orderDeliveryDatetime = orderDeliveryDatetime;
  }
  final String? deliveryType = jsonConvert.convert<String>(
      json['delivery_type']);
  if (deliveryType != null) {
    myorderDataResults.deliveryType = deliveryType;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['order_status']);
  if (orderStatus != null) {
    myorderDataResults.orderStatus = orderStatus;
  }
  final String? createdDate = jsonConvert.convert<String>(json['created_date']);
  if (createdDate != null) {
    myorderDataResults.createdDate = createdDate;
  }
  final int? amount = jsonConvert.convert<int>(json['amount']);
  if (amount != null) {
    myorderDataResults.amount = amount;
  }
  final int? deliveryId = jsonConvert.convert<int>(json['delivery_id']);
  if (deliveryId != null) {
    myorderDataResults.deliveryId = deliveryId;
  }
  final String? orderMode = jsonConvert.convert<String>(json['order_mode']);
  if (orderMode != null) {
    myorderDataResults.orderMode = orderMode;
  }
  final String? orderStatusDisplayText = jsonConvert.convert<String>(
      json['order_status_display_text']);
  if (orderStatusDisplayText != null) {
    myorderDataResults.orderStatusDisplayText = orderStatusDisplayText;
  }
  final String? orderStatusDisplay = jsonConvert.convert<String>(
      json['order_status_display']);
  if (orderStatusDisplay != null) {
    myorderDataResults.orderStatusDisplay = orderStatusDisplay;
  }
  return myorderDataResults;
}

Map<String, dynamic> $MyorderDataResultsToJson(MyorderDataResults entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['bill_no'] = entity.billNo;
  data['order_number'] = entity.orderNumber;
  data['order_delivery_datetime'] = entity.orderDeliveryDatetime;
  data['delivery_type'] = entity.deliveryType;
  data['order_status'] = entity.orderStatus;
  data['created_date'] = entity.createdDate;
  data['amount'] = entity.amount;
  data['delivery_id'] = entity.deliveryId;
  data['order_mode'] = entity.orderMode;
  data['order_status_display_text'] = entity.orderStatusDisplayText;
  data['order_status_display'] = entity.orderStatusDisplay;
  return data;
}

extension MyorderDataResultsExtension on MyorderDataResults {
  MyorderDataResults copyWith({
    String? id,
    String? billNo,
    String? orderNumber,
    String? orderDeliveryDatetime,
    String? deliveryType,
    String? orderStatus,
    String? createdDate,
    int? amount,
    int? deliveryId,
    String? orderMode,
    String? orderStatusDisplayText,
    String? orderStatusDisplay,
  }) {
    return MyorderDataResults()
      ..id = id ?? this.id
      ..billNo = billNo ?? this.billNo
      ..orderNumber = orderNumber ?? this.orderNumber
      ..orderDeliveryDatetime = orderDeliveryDatetime ??
          this.orderDeliveryDatetime
      ..deliveryType = deliveryType ?? this.deliveryType
      ..orderStatus = orderStatus ?? this.orderStatus
      ..createdDate = createdDate ?? this.createdDate
      ..amount = amount ?? this.amount
      ..deliveryId = deliveryId ?? this.deliveryId
      ..orderMode = orderMode ?? this.orderMode
      ..orderStatusDisplayText = orderStatusDisplayText ??
          this.orderStatusDisplayText
      ..orderStatusDisplay = orderStatusDisplay ?? this.orderStatusDisplay;
  }
}