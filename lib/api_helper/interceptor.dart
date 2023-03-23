import 'dart:convert';

import 'package:dio/dio.dart';

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print(
        'REQUEST[${options.method}] => PATH: ${options.uri} param ${options.queryParameters}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    print(
        'RESPONSE[${response.statusMessage}] => PATH: ${response.requestOptions.path}');
    print("- ${jsonEncode(response.data)}");
    return super.onResponse(response, handler);
  }

  @override
  onError(DioError err, ErrorInterceptorHandler handler) async {
    print(
        'ERROR[${err.message.toString()}] => PATH: ${err.requestOptions.path} ${err.type} -- ${err.response.toString()} -- ${err.type}');
    // try
    // {
    //   if(err.type == DioErrorType.other)
    //   {
    //     Map<String , dynamic> customResponse = {
    //       "error" : true,
    //       "message" : "No Internet"
    //     };
    //
    //     err.response = Response(data: customResponse, requestOptions: err.requestOptions);
    //     return handler.resolve(err.response!);
    //   }
    //   else if(err.type == DioErrorType.connectTimeout)
    //   {
    //     Map<String , dynamic> customResponse = {
    //       "error" : true,
    //       "message" : "Connection Timeout!"
    //     };
    //
    //     err.response = Response(data: customResponse, requestOptions: err.requestOptions);
    //     return handler.resolve(err.response!);
    //   }
    //   else if(err.response?.statusCode == 401 && err.requestOptions.path == "users/login")
    //   {
    //     return handler.resolve(err.response!);
    //   }
    //   else if(err.response?.statusCode == 401)
    //   {
    //     Response? tokenFetchResponse = await Api.getTokens({});
    //     if(tokenFetchResponse == null)
    //     {
    //       return handler.resolve(err.response!);
    //     }
    //     else
    //     {
    //       String uri = err.requestOptions.baseUrl+ err.requestOptions.path.toString().replaceFirst("/", "");
    //       Response retryRes = await retryResponse(uri , err);
    //       return handler.resolve(retryRes);
    //     }
    //   }
    //   else if(err.response?.statusCode == 400)
    //   {
    //     return handler.resolve(err.response!);
    //   }
    //   else
    //   {
    //     Map<String , dynamic> customResponse = {
    //       "error" : true,
    //       "message" : "Error Occurred."
    //     };
    //
    //     err.response = Response(data: customResponse, requestOptions: err.requestOptions);
    //     return handler.resolve(err.response!);
    //   }
    // }
    // catch(e)
    // {
    //   Map<String , dynamic> customResponse = {
    //     "error" : true,
    //     "message" : "Error Occurred."
    //   };
    //
    //   err.response = Response(data: customResponse, requestOptions: err.requestOptions);
    return handler.resolve(err.response!);
  }
}

// Future retryResponse(String uri , DioError err)
// async {
//   Dio dio = Dio();
//   dio.interceptors.add(CustomInterceptors());
//   FlutterSecureStorageUtility flutterSecureStorageUtility = FlutterSecureStorageUtility();
//   String? token = await flutterSecureStorageUtility.readValue(StringConstants.authToken);
//
//   dio.options.headers =
//   {
//     StringConstants.accessToken : "Bearer $token"
//   };
//   dio.options.method = err.requestOptions.method;
//   dio.options.queryParameters = err.requestOptions.queryParameters;
//   Response retryResponse = await dio.request(uri);
//   return retryResponse;
// }
