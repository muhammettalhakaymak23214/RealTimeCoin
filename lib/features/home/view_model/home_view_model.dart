import 'dart:convert';
import 'package:mobx/mobx.dart';
import 'package:realtime_coin/core/services/cache/local_storage_service.dart';
import 'package:realtime_coin/core/services/navigation/navigation_service.dart';
import 'package:realtime_coin/features/home_edit/view/home_edit_view.dart';
import '../service/home_service.dart';

class HomeViewModel {
  final IHomeService _service;
  HomeViewModel(this._service);

  // Observable Haritalar
  final ObservableMap<String, String> prices = ObservableMap<String, String>();
  final ObservableMap<String, String> changes = ObservableMap<String, String>();
  final ObservableMap<String, String> highs = ObservableMap<String, String>();
  final ObservableMap<String, String> lows = ObservableMap<String, String>();
  final ObservableMap<String, String> volumes = ObservableMap<String, String>();
  final ObservableMap<String, String> quoteVolumes = ObservableMap<String, String>();
  final ObservableMap<String, int> updateTimes = ObservableMap<String, int>();
  final ObservableMap<String, int> tradeCounts = ObservableMap<String, int>();
  final ObservableMap<String, String> openPrices = ObservableMap<String, String>();

  @action
  void clearAllData() {
    prices.clear();
    changes.clear();
    highs.clear();
    lows.clear();
    volumes.clear();
    quoteVolumes.clear();
    updateTimes.clear();
    tradeCounts.clear();
    openPrices.clear();
  }

  void startStreaming() {
    clearAllData();

    final allSymbols = LocalStorageService.instance.getSelectedSymbols();
    
  
    final List<String> targetSymbols = allSymbols
        .take(10) 
        .map((s) => s.toLowerCase().trim()) 
        .toList();

    if (targetSymbols.isEmpty) {
      print("İzlenecek sembol bulunamadı (Hive boş).");
      return;
    }

    print("Bağlanılan semboller: $targetSymbols");

    _service.listenToTickers(
      symbols: targetSymbols,
      onData: (message) {
        final decoded = jsonDecode(message);
        
       
        if (decoded.containsKey('error')) {
          print("Binance API Hatası: ${decoded['error']}");
          return;
        }

        final data = decoded['data'];
        if (data != null) {
          runInAction(() {
       
            final String s = data['s'].toString().toUpperCase(); 

            prices[s] = data['c'].toString();
            changes[s] = data['P'].toString();
            highs[s] = data['h'].toString();
            lows[s] = data['l'].toString();
            volumes[s] = data['v'].toString();
            quoteVolumes[s] = data['q'].toString();
            updateTimes[s] = data['E'] as int;
            tradeCounts[s] = data['n'] as int;
            openPrices[s] = data['o'].toString();
          });
        }
      },
      onError: (err) => print("WebSocket Hatası: $err"),
    );
  }

  void stopStreaming() {
    _service.stop();
    clearAllData();
  }

  @action
  Future<void> navigateToEditAndRefresh() async {
 
    await NavigationService.instance.navigateToPage(page: const HomeEditView());

  
    stopStreaming();
    startStreaming();
  }

}