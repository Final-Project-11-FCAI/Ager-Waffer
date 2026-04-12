import 'package:signalr_netcore/signalr_client.dart';

class ChatService {
  late HubConnection _connection;

  final List<Function(String user, String message)> _listeners = [];

  Future<void> connect(String token) async {
    _connection = HubConnectionBuilder()
        .withUrl(
      "https://ajarwaffer.runasp.net/chatHub",
      options: HttpConnectionOptions(
        accessTokenFactory: () async => token,
      ),
    )
        .withAutomaticReconnect()
        .build();

    _connection.on("ReceiveMessage", (data) {
      for (var listener in _listeners) {
        listener(data![0].toString(), data[1].toString());
      }
    });

    await _connection.start();
  }

  Future<void> joinRoom(String roomId) async {
    await _connection.invoke("JoinRoom", args: [roomId]);
  }

  Future<void> sendMessage(
      String roomId, String user, String message) async {
    await _connection.invoke(
      "SendMessage",
      args: [roomId, user, message],
    );
  }

  void onMessage(Function(String, String) callback) {
    _listeners.add(callback);
  }

  Future<void> disconnect() async {
    await _connection.stop();
  }
}