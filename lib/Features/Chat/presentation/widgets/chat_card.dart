import 'package:ager_waffer/Features/Chat/presentation/pages/chat_screen.dart';
import 'package:ager_waffer/Features/Chat/data/models/all_chats_model.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key, required this.chat,
  });

  final Data chat;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(),
            ),
          ),
          leading: CircleAvatar(
            backgroundImage: chat.profileImage == null ? AssetImage('assets/images/virtual_user.jpg') : NetworkImage(chat.profileImage!),
          ),
          title: Text(chat.username ?? ''),
          subtitle: Text(chat.lastMessageContent ?? ''),
          trailing: chat.unreadCount == 0 ? null : Badge(
            padding: EdgeInsets.symmetric(horizontal: 12),
            label: Text(chat.unreadCount.toString()),
            largeSize: 30,
          )),
    );
  }
}