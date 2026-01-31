import 'package:realtime_coin/core/constants/api_constants.dart';
import 'package:realtime_coin/core/network/binance_websocket_manager.dart';

abstract class IHomeService {
  void listenToTickers({
    required List<String> symbols,
    required Function(dynamic) onData,
    required Function(dynamic) onError,
  });
  void stop();
}

class HomeService implements IHomeService {
  final WebSocketManager _manager;
  HomeService(this._manager);

  @override
  void listenToTickers({
    required List<String> symbols,
    required Function(dynamic) onData,
    required Function(dynamic) onError,
  }) {
    final url = ApiConstants.buildTickerStream(symbols);
    _manager.connect(url, onData: onData, onError: onError);
  }

  @override
  void stop() => _manager.disconnect();
}
