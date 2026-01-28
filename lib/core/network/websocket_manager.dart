import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketManager {
  WebSocketChannel? _channel;

  void connect(String url, {required Function(dynamic) onData, required Function(dynamic) onError}) {
    _channel = WebSocketChannel.connect(Uri.parse(url));
    _channel!.stream.listen(onData, onError: onError);
  }

  void disconnect() {
    _channel?.sink.close();
  }
}