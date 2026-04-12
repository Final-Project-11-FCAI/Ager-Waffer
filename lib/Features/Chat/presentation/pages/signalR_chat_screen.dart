import 'package:ager_waffer/Features/Chat/data/models/message_model.dart';
import 'package:ager_waffer/Features/Chat/data/repositories/signalR_service.dart';
import 'package:ager_waffer/Features/Chat/presentation/widgets/message_bubble.dart';
import 'package:flutter/material.dart';

class SignalRChatScreen extends StatefulWidget {
  final String roomId;
  final String user;
  final String token;

  const SignalRChatScreen({super.key,
    required this.roomId,
    required this.user,
    required this.token,
  });

  @override
  State<SignalRChatScreen> createState() => _SignalRChatScreenState();
}

class _SignalRChatScreenState extends State<SignalRChatScreen> {
  final ChatService _chatService = ChatService();
  final TextEditingController _controller = TextEditingController();

  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    initChat();
  }

  void initChat() async {
    await _chatService.connect(widget.token);
    await _chatService.joinRoom(widget.roomId);

    _chatService.onMessage((user, msg) {
      setState(() {
        messages.add(
          Message(
            user: user,
            text: msg,
            isMe: user == widget.user,
            time: DateTime.now(),
          ),
        );
      });
    });
  }

  void sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    final msg = _controller.text;

    _chatService.sendMessage(widget.roomId, widget.user, msg);

    setState(() {
      messages.add(
        Message(
          user: widget.user,
          text: msg,
          isMe: true,
          time: DateTime.now(),
        ),
      );
    });

    _controller.clear();
  }

  @override
  void dispose() {
    _chatService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (_, i) {
                final msg = messages[messages.length - 1 - i];
                return MessageBubble(
                  text: msg.text,
                  isMe: msg.isMe,
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration:
                  InputDecoration(hintText: "Type message"),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: sendMessage,
              )
            ],
          )
        ],
      ),
    );
  }
}