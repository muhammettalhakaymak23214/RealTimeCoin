import 'package:realtime_coin/core/network/binance_network_manager.dart';

class BinanceService {
  Future<List<String>> fetchSymbols() async {
    try {
      final response = await NetworkManager.instance.dio.get('exchangeInfo');

      if (response.statusCode == 200) {
        final List symbols = response.data['symbols'];
        
        return symbols
            .where((s) => s['status'] == 'TRADING')
            .where((s) => s['quoteAsset'] == 'USDT' || s['quoteAsset'] == 'BTC') 
            .map((s) => s['symbol'].toString())
            .toList();
      }
      return [];
    } catch (e) {
      return Future.error("Veri çekme hatası: $e");
    }
  }
}