import 'package:dio/dio.dart';
import 'package:realtime_coin/features/news/model/news_model.dart';

class NewsService {
  final Dio _dio = Dio();
  

  final String _apiKey = "24d32e6749e060c10840182b851e78e36b37279a8e5ed56649407a18859ae1b4";
  final String _baseUrl = "https://min-api.cryptocompare.com/data/v2/news/";

  Future<List<NewsModel>> fetchNews() async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'lang': 'TR',
          'api_key': _apiKey, // API Key burada gönderiliyor
        },
      );

      if (response.statusCode == 200) {
        // Gelen JSON'daki 'Data' listesine erişiyoruz
        final List<dynamic> newsData = response.data['Data'];
        return newsData.map((json) => NewsModel.fromJson(json)).toList();
      } else {
        throw Exception('Haberler getirilemedi');
      }
    } catch (e) {
      throw Exception('Bir hata oluştu: $e');
    }
  }
}