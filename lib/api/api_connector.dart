import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class APIConnector {
  late Dio open;
  late Future<Dio> closed;
  static const baseUrl = "http://10.10.24.1:8000/";
  APIConnector() {
    open = createOpenDio();
  }
  APIConnector.protected() {
    closed = createProtectedDio();
  }

  Dio createOpenDio() {
    return Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      baseUrl: baseUrl,
      contentType: 'application/json',
      // headers: {
      //   'Authorization': 'Bearer ',
      // }
    ));
  }

  Future<Dio> createProtectedDio() async {
    const storage = FlutterSecureStorage();
    String? access = await storage.read(key: "access");
    String? refresh = await storage.read(key: "refresh");
    Dio dio = Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        baseUrl: baseUrl,
        contentType: 'application/json',
        headers: {
          'Authorization': 'Bearer ${access ?? ''}',
        }));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          // Do something before request is sent.
          // If you want to resolve the request with custom data,
          // you can resolve a `Response` using `handler.resolve(response)`.
          // If you want to reject the request with a error message,
          // you can reject with a `DioException` using `handler.reject(dioError)`.
          // debugPrint("request sent !${options.path}");
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          // Do something with response data.
          // If you want to reject the request with a error message,
          // you can reject a `DioException` object using `handler.reject(dioError)`.
          // debugPrint("response sent ! ${response.requestOptions.path} code =${response.statusCode}");
          return handler.next(response);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          if (error.response?.statusCode == 401) {
            // token maybe expired
            Dio updateToken = Dio();
            try {
              // gets the new token from refresh token
              Response response = await updateToken.post(
                  '${baseUrl}api/token/refresh/',
                  data: {'refresh': refresh});
              await storage.write(
                  key: "access", value: response.data["access"]);
              RequestOptions requestOptions = error.requestOptions;
              requestOptions.headers['Authorization'] =
                  'Bearer ${response.data['access']}';
              debugPrint("New Access token added");
              Response newResponse = await dio.request(requestOptions.path,
                  options: Options(
                    method: requestOptions.method,
                    headers: requestOptions.headers,
                    sendTimeout: requestOptions.sendTimeout,
                    receiveTimeout: requestOptions.receiveTimeout,
                    extra: requestOptions.extra,
                    responseType: requestOptions.responseType,
                    contentType: requestOptions.contentType,
                    validateStatus: requestOptions.validateStatus,
                  ),
                  data: requestOptions.data);
              debugPrint("Previous request called");
              return handler.resolve(newResponse);
            } on DioException catch (e) {
              // refresh token maybe expired
              debugPrint("Refresh token Expired");
              return handler.next(e);
            }
          }
          return handler.next(error);
        },
      ),
    );
    return dio;
  }
}
