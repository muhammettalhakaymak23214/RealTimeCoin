import 'package:mobx/mobx.dart';
import 'package:realtime_coin/features/add_symbol/service/binance_service.dart';

class AddSymbolViewModel {
  final BinanceService _service = BinanceService();

  // Tüm sembollerin tutulduğu ana liste
  List<String> _allSymbols = [];

  // Ekranda gösterilecek filtrelenmiş liste
  final ObservableList<String> filteredSymbols = ObservableList<String>();

  // Yüklenme durumu
  final Observable<bool> isLoading = Observable(false);

  Future<void> fetchAllSymbols() async {
    runInAction(() => isLoading.value = true);
    try {
      final data = await _service.fetchSymbols();
      _allSymbols = data;
      runInAction(() {
        filteredSymbols.clear();
        filteredSymbols.addAll(_allSymbols);
      });
    } finally {
      runInAction(() => isLoading.value = false);
    }
  }

  // Arama Algoritması
  void filterSymbols(String query) {
    runInAction(() {
      if (query.isEmpty) {
        filteredSymbols.clear();
        filteredSymbols.addAll(_allSymbols);
      } else {
        // Küçük/Büyük harf duyarsız arama
        filteredSymbols.clear();
        filteredSymbols.addAll(
          _allSymbols.where((s) => s.toLowerCase().contains(query.toLowerCase())).toList(),
        );
      }
    });
  }
}