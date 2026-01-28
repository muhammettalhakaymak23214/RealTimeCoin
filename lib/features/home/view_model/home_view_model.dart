import 'dart:convert';
import 'package:mobx/mobx.dart';
import '../service/home_service.dart';

class HomeViewModel {
  final IHomeService _service;
  HomeViewModel(this._service);

  final ObservableMap<String, String> prices = ObservableMap<String, String>();
  final ObservableMap<String, String> changes = ObservableMap<String, String>();
  final ObservableMap<String, String> highs = ObservableMap<String, String>();
  final ObservableMap<String, String> lows = ObservableMap<String, String>();
  final ObservableMap<String, String> volumes = ObservableMap<String, String>();
  final ObservableMap<String, String> quoteVolumes = ObservableMap<String, String>();
  final ObservableMap<String, int> updateTimes = ObservableMap<String, int>();
  final ObservableMap<String, int> tradeCounts = ObservableMap<String, int>();
  final ObservableMap<String, String> openPrices = ObservableMap<String, String>();

  void startStreaming() {
    final List<String> targetSymbols = [
      "BTCUSDT", "ETHUSDT", "SOLUSDT", "AVAXUSDT", "BNBUSDT",
      "XRPUSDT", "ADAUSDT", "DOTUSDT", "DOGEUSDT", "LINKUSDT"
    ];

    _service.listenToTickers(
      symbols: targetSymbols,
      onData: (message) {
        runInAction(() {
          final data = jsonDecode(message)['data'];
          final String s = data['s']; // Symbol

          prices[s] = data['c'].toString();          // Last Price
          changes[s] = data['P'].toString();         // Price Change Percent
          highs[s] = data['h'].toString();           // High Price
          lows[s] = data['l'].toString();            // Low Price
          volumes[s] = data['v'].toString();         // Base Volume
          quoteVolumes[s] = data['q'].toString();    // Quote Volume (USDT)
          updateTimes[s] = data['E'] as int;         // Event Time
          tradeCounts[s] = data['n'] as int;         // Total Trades
          openPrices[s] = data['o'].toString();      // Open Price
        });
      },
      onError: (err) => print("Hata: $err"),
    );
  }

  void stopStreaming() => _service.stop();
}