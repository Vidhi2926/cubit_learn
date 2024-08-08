import 'package:cubit_learn/Screens/MyOrder/Model/myorder_entity.dart';
import 'package:cubit_learn/api/api.dart';

class MyorderRepo {
  ProductionApi api = ProductionApi();

  Future<MyorderEntity?> fetchOrders(
      int page, {
        required String billNo,
      }) async {
    try {
      final response = await api.sendRequest.post(
        "/orders/list",
        data: {
          "user_id": "7abqoQ2Jk4kTwL/fZlSGig==",
          "patient_id": "",
          "device_id": "465d4664c7ea102f",
          "accesstoken": "-ODrRk3MU9emOBxTiX",
          "fcmtoken": "diPc5RrGSy2oB6C6HbMC6T:APA91bHZPWmSvuoRdVnRtkqfQQHpOPB8QM8SZ7aOMBwOAv_aoMvCqnBEZOoFZmo2tsYZFCdParH5ZrWiZulvvCbNiob3LOdE_-xil0MjXzd7sQVqXdr9Gkqs0akV7BMIlAvwqcZ-tH0x",
          "app_version": "10",
          "os": "android",
          "apikey": "R08mGEm4550Bi69AHobdH9E4QY02f1N7",
          "page": page,
          "order_status": '',
          "order_number": '',
          "bill_no": billNo,
        },
      );

      if (response.statusCode == 200) {
        var myorderEntity = MyorderEntity.fromJson(response.data);
        if (myorderEntity.statusCode == '1') {
          return myorderEntity;
        } else {
          print('Error: ${myorderEntity.statusMessage}');
          return null;
        }
      } else if (response.statusCode == 404) {
        print('Error 404: Resource not found');
        return null;
      } else {
        print('HTTP error: ${response.statusCode} ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      print('Exception occurred: $e');
      return null;
    }
  }
}
