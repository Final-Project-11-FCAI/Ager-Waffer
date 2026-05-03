import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Chat/data/models/message_model.dart';
import 'package:ager_waffer/Features/Chat/data/models/room_models.dart';
import 'package:ager_waffer/Features/Chat/data/models/user_model.dart';
import 'package:ager_waffer/Features/Chat/presentation/pages/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatCard extends StatelessWidget {
  final ChatRoom item;

  const ChatCard({super.key, required this.item});

  DateTime getDateTime(dynamic timestamp) {
    print("timestamp : ${timestamp.runtimeType} , $timestamp");
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    } else if (timestamp is int) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    } else if (timestamp is String) {
      return DateTime.parse(timestamp);
    }
    return DateTime.now();
  }

  Color getColorFromName(String name) {
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
      Colors.cyan,
      Colors.brown,
    ];

    final index = name.hashCode % colors.length;
    return colors[index.abs()];
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    if (currentUserId == null ||
        item.members == null ||
        item.members!.isEmpty) {
      return const SizedBox();
    }

    final otherMembers = item.members!
        .where((element) => element != currentUserId)
        .toList();

    if (otherMembers.isEmpty) {
      return const SizedBox();
    }

    final String userId = otherMembers.first;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data?.data() != null) {
          final raw = snapshot.data!.data()!;
          // Ensure we always have a valid non-empty id for this user
          final chatUser = ChatUser.fromJson({
            ...raw,
            'id': raw['id'] ?? snapshot.data!.id,
          });

          return Card(
            color: isDark ? kSomeDarkModeColor : kSmallContainerColor,
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ChatScreen(roomId: item.id!, chatUser: chatUser),
                  ),
                );
              },
              leading:
                  // chatUser.image == null ?
                  CircleAvatar(
                    backgroundColor: getColorFromName(chatUser.name!),
                    child: Text(
                      (chatUser.name != null && chatUser.name!.isNotEmpty)
                          ? chatUser.name!.characters.first
                          : '?',
                      style: TextStyle(
                        color: isDark ? kWhiteColor : kWhiteColor,
                      ),
                    ),
                  ),
              // : CircleAvatar(
              //     backgroundImage: chatUser.image == null?  NetworkImage(chatUser.image!) : AssetImage("assets/images/virtual_user.jpg"),
              //   ),
              title: Text(chatUser.name ?? '', overflow: TextOverflow.ellipsis),
              subtitle: Text(
                item.lastMessage?.isEmpty ?? true
                    ? chatUser.about!
                    : item.lastMessage!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('rooms')
                    .doc(item.id)
                    .collection('messages')
                    .snapshots(),
                builder: (context, messageSnapshot) {
                  if (messageSnapshot.hasData) {
                    print('item.lastMessageTime : ${item.lastMessageTime}');
                    final unReadList = messageSnapshot.data!.docs
                        .map((e) => Message.fromJson(e.data()))
                        .where(
                          (msg) =>
                              msg.read == null &&
                              msg.fromId !=
                                  FirebaseAuth.instance.currentUser!.uid,
                        )
                        .toList();

                    return unReadList.isNotEmpty
                        ? Badge(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            label: Text(unReadList.length.toString()),
                            largeSize: 30,
                          )
                        : Text(
                            DateFormat('hh:mm a').format(
                              getDateTime(item.lastMessageTime),
                            ), //item.lastMessageTime
                          );
                  }
                  return SizedBox();
                },
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
