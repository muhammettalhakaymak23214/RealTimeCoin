import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
 LocalStorageService._init();
  static final LocalStorageService _instance = LocalStorageService._init();
  static LocalStorageService get instance => _instance;

  // Selected Symbols
  Box get _symbolBox => Hive.box('selected_symbols');

  // Save Selected Symbols
  void saveSymbol(String symbol) {
    _symbolBox.put(symbol, symbol); 
  }

  // Delete Selected Symbols
  Future<void> deleteSymbol(String symbol) async {
    await _symbolBox.delete(symbol);
  }

  // Get Selected Symbols
  List<String> getSelectedSymbols() {
    return _symbolBox.values.cast<String>().toList();
  }

 
}