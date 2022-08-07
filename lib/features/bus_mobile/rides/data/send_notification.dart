  
import 'package:dio/dio.dart';
import '../../../../core/exceptions/exception.dart';
import '../../../../core/resources/endpoints_manager.dart';

import '../../../../core/resources/debugger_manager.dart';

class SendNotificationApiClient {
  late Dio dio;
  SendNotificationApiClient() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://fcm.googleapis.com/',
      headers: <String, String>{
       'Content-Type': 'application/json',
       'Authorization': 'key = 403200399686',
     }
    ));
  }
  Future<void> sendNotification(String rideId) async {
    final data =  <String, dynamic>{
       'notification': <String, dynamic>{
         'body': 'this is a body',
         'title': 'this is a title'
       },
       'priority': 'high',
       'data': <String, dynamic>{
         'click_action': 'FLUTTER_NOTIFICATION_CLICK',
       },
       'to': 'topics/rideId',
     };
    try {
      Response response =
          await dio.post('fcm/send', data : data);
    } on DioError {
      throw ServerException();
    }
  }
}
