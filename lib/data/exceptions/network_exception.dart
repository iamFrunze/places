class NetworkException implements Exception {
  final String nameRequest;
  final String nameError;
  final int code;

  NetworkException({required this.code, required this.nameRequest, required this.nameError});

  @override
  String toString() => '$nameRequest возникла ошибка: $code $nameError';
}
