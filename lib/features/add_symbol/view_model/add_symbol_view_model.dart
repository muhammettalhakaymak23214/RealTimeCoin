import 'package:mobx/mobx.dart';
import 'package:realtime_coin/features/add_symbol/service/binance_service.dart';

class AddSymbolViewModel {
  final BinanceService _service = BinanceService();


  List<String> _allSymbols = [];


  final ObservableList<String> filteredSymbols = ObservableList<String>();


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

  void filterSymbols(String query) {
    runInAction(() {
      if (query.isEmpty) {
        filteredSymbols.clear();
        filteredSymbols.addAll(_allSymbols);
      } else {
      
        filteredSymbols.clear();
        filteredSymbols.addAll(
          _allSymbols.where((s) => s.toLowerCase().contains(query.toLowerCase())).toList(),
        );
      }
    });
  }
}