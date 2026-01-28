class ApiConstants {
  static const String baseStreamUrl = "wss://stream.binance.com:9443/stream?streams=";
  
  static String buildTickerStream(List<String> symbols) {
    final streams = symbols.map((s) => "${s.toLowerCase()}@ticker").join("/");
    return "$baseStreamUrl$streams";
  }
}