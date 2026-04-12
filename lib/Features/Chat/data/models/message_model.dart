class Message {
  final String user;
  final String text;
  final bool isMe;
  final DateTime time;

  Message({
    required this.user,
    required this.text,
    required this.isMe,
    required this.time,
  });
}