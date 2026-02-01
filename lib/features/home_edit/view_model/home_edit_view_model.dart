import 'package:mobx/mobx.dart';
import 'package:realtime_coin/core/services/cache/local_storage_service.dart';

class HomeEditViewModel {
  final ObservableList<String> symbols = ObservableList<String>();

  void loadSymbols() {
    runInAction(() {
      symbols.clear();
      final data = LocalStorageService.instance.getSelectedSymbols();
      symbols.addAll(data);
    });
  }

  Future<void> removeSymbol(String symbol) async {
    await LocalStorageService.instance.deleteSymbol(symbol);
    runInAction(() {
      symbols.remove(symbol);
    });
  }
}