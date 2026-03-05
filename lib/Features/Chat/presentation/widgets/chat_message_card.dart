import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Chat/data/models/firebase/fire_database.dart';
import 'package:ager_waffer/Features/Chat/data/models/message_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatMessageCard extends StatefulWidget {
  final int index;
  final Message messageItem;
  final String roomId;
  final bool selected;

  const ChatMessageCard({
    super.key,
    required this.index,
    required this.messageItem,
    required this.roomId,
    required this.selected,
  });

  @override
  State<ChatMessageCard> createState() => _ChatMessageCardState();
}

class _ChatMessageCardState extends State<ChatMessageCard> {
  @override
  void initState() {
    if (widget.messageItem.toId == FirebaseAuth.instance.currentUser!.uid) {
      FireData().readMessage(widget.roomId, widget.messageItem.id!);
    }
    super.initState();
  }

  String _formatTimestamp(String? timestamp) {
    if (timestamp == null || int.tryParse(timestamp) == null) {
      return "Invalid date";
    }
    int milliseconds = int.parse(timestamp);
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    return DateFormat('hh:mm a').format(dateTime); // Example: Fri, Feb 7, 2025
  }

  @override
  Widget build(BuildContext context) {
    bool isMe =
        widget.messageItem.fromId == FirebaseAuth.instance.currentUser!.uid;
    return Container(
      decoration: BoxDecoration(
          color: widget.selected ? Colors.grey : Colors.transparent, borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          isMe
              ? IconButton(onPressed: () {}, icon: Icon(Icons.message_sharp))
              : SizedBox(),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(isMe ? 16 : 0),
              bottomRight: Radius.circular(isMe ? 0 : 16),
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            )),
            color: isMe
                ? Theme.of(context).colorScheme.background
                : Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.sizeOf(context).width / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.messageItem.type == 'image'
                        ? Container(
                            child: CachedNetworkImage(
                              imageUrl: widget.messageItem.msg!,
                              placeholder: (context, url) {
                                return CircularProgressIndicator(
                                  color: kPrimaryColor,
                                );
                              },
                            ),
                          )
                        : Text(widget.messageItem.msg!),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        isMe
                            ? Icon(
                                Icons.airplane_ticket_rounded,
                                color: widget.messageItem.read == null
                                    ? Colors.grey
                                    : Colors.blueAccent,
                                size: 18,
                              )
                            : SizedBox(),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          _formatTimestamp(widget.messageItem.createdAt),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
