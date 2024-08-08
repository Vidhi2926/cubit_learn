import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Api {
  final Dio _dio = Dio();

  Api() {
    _dio.options.baseUrl = "https://dev-api.evitalrx.in/v1/whitelabel";
    _dio.interceptors.add(PrettyDioLogger(
      requestBody: true, // Enables logging the request payload
    ));
    //Adds another custom interceptor using InterceptorsWrapper.
    // This interceptor prints the request payload to the console before sending the request.
    // handler.next(options) continues with the request.
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        // Print the payload (request data)
        print("Request Payload: ${options.data}");
        return handler.next(options); // Continue with the request
      },
    ));
  }

  Dio get sendRequest => _dio;
}

class ProductionApi {
  final Dio _api = Dio();

  ProductionApi() {
    _api.options.baseUrl = "https://api.evitalrx.in/v1/whitelabel";
    _api.interceptors.add(PrettyDioLogger(
      requestBody: true, // Enables logging the request payload
    ));
    _api.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        // Print the payload (request data)
        print("Request Payload: ${options.data}");
        return handler.next(options); // Continue with the request
      },
    ));
  }

  Dio get sendRequest => _api;
}
