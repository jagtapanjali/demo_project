import 'package:demo/api_helper/apis.dart';
import 'package:demo/api_helper/interceptor.dart';
import 'package:dio/dio.dart';

class ApiService {
  var options = BaseOptions(
    baseUrl: APIs.baseUrl,
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 10),
  );

  late Dio dio = Dio();

  ApiService() {
    dio.options = options;
    dio.interceptors.add(CustomInterceptors());
  }

  Future<Response> get(String route, {Map<String, dynamic>? data}) async {
    data = data ?? {};
    Response response = await dio.get(route, queryParameters: data);
    return response;
  }

  Future<Response> post(String route, {Map<String, dynamic>? data}) async {
    Response response =
        await dio.post(route, queryParameters: data, data: data);
    return response;
  }
}
