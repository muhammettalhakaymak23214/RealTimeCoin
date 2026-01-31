

import 'package:dio/dio.dart';

class NetworkManager {
  static NetworkManager? _instance;
  static NetworkManager get instance => _instance ??= NetworkManager._init();

  late final Dio dio;

  NetworkManager._init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://api.binance.com/api/v3/',
      connectTimeout: const Duration(seconds: 5),
    ));
  }
}