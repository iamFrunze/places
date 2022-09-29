import 'package:dio/dio.dart';

class DioSettings {
  final _baseUrl = 'https://test-backend-flutter.surfstudio.ru';
  final _connectTimeout = 5000;
  final _receiveTimeout = 5000;
  final _sendTimeout = 5000;
  final _responseType = ResponseType.json;

  Dio get dio => _dio;

  late Dio _dio;

  DioSettings() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: _connectTimeout,
        receiveTimeout: _receiveTimeout,
        sendTimeout: _sendTimeout,
        responseType: _responseType,
      ),
    );
    dio.interceptors.add(LogInterceptor(responseBody: false));
  }
}
