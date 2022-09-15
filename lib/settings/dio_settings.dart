import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioSettings {
  final _baseUrl = 'https://test-backend-flutter.surfstudio.ru';
  final _testBaseUrl = 'https://jsonplaceholder.typicode.com/users';
  final _connectTimeout = 5000;
  final _receiveTimeout = 5000;
  final _sendTimeout = 5000;
  final _responseType = ResponseType.json;

  Dio get dio => _dio;

  late Dio _dio;

  DioSettings() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _testBaseUrl,
        connectTimeout: _connectTimeout,
        receiveTimeout: _receiveTimeout,
        sendTimeout: _sendTimeout,
        responseType: _responseType,
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (e, handler) => debugPrint('error $e'),
        onResponse: (response, handler) {
          debugPrint('Dio ressponse: \n $response');

          return handler.next(response);
        },
      ),
    );
  }
}
