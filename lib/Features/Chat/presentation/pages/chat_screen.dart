import 'dart:io';

import 'package:ager_waffer/Features/Chat/data/models/firebase/fire_database.dart';
import 'package:ager_waffer/Features/Chat/data/models/firebase/fire_storage.dart';
import 'package:ager_waffer/Features/Chat/data/models/message_model.dart';
import 'package:ager_waffer/Features/Chat/data/models/user_model.dart';
import 'package:ager_waffer/Features/Chat/presentation/widgets/chat_message_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.roomId, required this.chatUser});

  final String roomId;
  final ChatUser chatUser;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController msgCon = TextEditingController();

  List<String> selectedMsg = [];
  List<String> copyMsg = [];

  String formatLastSeen(dynamic timestamp) {
    DateTime lastSeen = getDateTime(timestamp);
    DateTime now = DateTime.now();

    Duration diff = now.difference(lastSeen);

    if (diff.inDays >= 1) {
      // More than one day ago → show date
      return DateFormat('dd/MM/yyyy').format(lastSeen);
    } else {
      // Same day → show time
      return DateFormat('hh:mm a').format(lastSeen);
    }
  }


  DateTime getDateTime(dynamic timestamp) {
    print("timestamp : ${timestamp.runtimeType} , $timestamp");

    if (timestamp is Timestamp) {
      // Firestore Timestamp
      return timestamp.toDate();

    } else if (timestamp is int) {
      // Milliseconds since epoch
      return DateTime.fromMillisecondsSinceEpoch(timestamp);

    } else if (timestamp is String) {
      // Check if the string is a number
      if (RegExp(r'^\d+$').hasMatch(timestamp)) {
        // It's numeric milliseconds
        return DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
      } else {
        // It's a date string
        return DateTime.parse(timestamp);
      }
    }

    // Fallback
    return DateTime.now();
  }


  @override
  Widget build(BuildContext context) {
    final String roomId = widget.roomId;
    final String? userId = widget.chatUser.id;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.chatUser.name ?? ''),
            if (userId != null && userId.isNotEmpty)
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(userId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data?.data() != null) {
                      final data = snapshot.data!.data()!;
                      return Text(
                        (data['online'] as bool? ?? false)
                            ? "Online"
                            : 'Last Seen at ${formatLastSeen(data['last_activated'] ?? widget.chatUser.lastActivated)}',
                        style: Theme.of(context).textTheme.labelLarge,
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
          ],
        ),
        actions: [
          selectedMsg.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    FireData().deleteMsg(widget.roomId, selectedMsg);
                    setState(() {
                      selectedMsg.clear();
                      copyMsg.clear();
                    });
                  },
                  icon: const Icon(Icons.delete),
                )
              : Container(),
          copyMsg.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: copyMsg.join(' \n')));
                    setState(() {
                      copyMsg.clear();
                      selectedMsg.clear();
                    });
                  },
                  icon: const Icon(Icons.copy),
                )
              : Container()
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: roomId.isEmpty
                      ? const Stream.empty()
                      : FirebaseFirestore.instance
                          .collection('rooms')
                          .doc(roomId)
                          .collection('messages')
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<Message> messageItems = snapshot.data!.docs
                          .map((e) => Message.fromJson(e.data()))
                          .toList()
                          .cast<Message>();

                      // Newest messages first
                      messageItems.sort(
                        (Message a, Message b) =>
                            b.createdAt!.compareTo(a.createdAt!),
                      );
                      return messageItems.isNotEmpty
                          ? ListView.builder(
                              reverse: true,
                              itemCount: messageItems.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedMsg.isNotEmpty
                                          ? selectedMsg.contains(
                                                  messageItems[index].id)
                                              ? selectedMsg.remove(
                                                  messageItems[index].id)
                                              : selectedMsg
                                                  .add(messageItems[index].id!)
                                          : null;
                                      copyMsg.isNotEmpty
                                          ? messageItems[index].type == 'text'
                                              ? copyMsg.contains(
                                                      messageItems[index].msg)
                                                  ? copyMsg.remove(
                                                      messageItems[index].msg!)
                                                  : copyMsg.add(
                                                      messageItems[index].msg!)
                                              : null
                                          : null;
                                      print(copyMsg);
                                    });
                                  },
                                  onLongPress: () {
                                    setState(() {
                                      selectedMsg
                                              .contains(messageItems[index].id)
                                          ? selectedMsg
                                              .remove(messageItems[index].id)
                                          : selectedMsg
                                              .add(messageItems[index].id!);
                                      messageItems[index].type == 'text'
                                          ? copyMsg.contains(
                                                  messageItems[index].msg)
                                              ? copyMsg.remove(
                                                  messageItems[index].msg!)
                                              : copyMsg
                                                  .add(messageItems[index].msg!)
                                          : null;
                                    });
                                  },
                                  child: ChatMessageCard(
                                    selected: selectedMsg
                                        .contains(messageItems[index].id),
                                    messageItem: messageItems[index],
                                    index: index,
                                    roomId: widget.roomId,
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: GestureDetector(
                                onTap: () => FireData().sendMessage(
                                    widget.chatUser.id!,
                                    "Assalamu Alaikum 👋",
                                    widget.roomId,
                                    widget.chatUser,
                                    context),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "👋",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Text(
                                          "Say Assalamu Alaikum",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                    }
                    return Container();
                  }),
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: TextField(
                      controller: msgCon,
                      maxLines: 5,
                      minLines: 1,
                      decoration: InputDecoration(
                          suffixIcon: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  ImagePicker picker = ImagePicker();
                                  XFile? image = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  if (image != null) {
                                    FireStorage().sendImage(
                                      file: File(image.path),
                                      roomId: widget.roomId,
                                      uid: widget.chatUser.id!,
                                      chatUser: widget.chatUser,
                                      context: context,
                                    ); // Correctly create the file
                                  }
                                },
                                icon: const Icon(Icons.camera),
                              ),
                            ],
                          ),
                          border: InputBorder.none,
                          hintText: "Message",
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10)),
                    ),
                  ),
                ),
                IconButton.filled(
                    onPressed: () {
                      if (msgCon.text.isNotEmpty) {
                        FireData()
                            .sendMessage(widget.chatUser.id!, msgCon.text,
                                widget.roomId, widget.chatUser, context)
                            .then((value) {
                          setState(() {
                            msgCon.text = '';
                          });
                        });
                      }
                    },
                    icon: Icon(Icons.send))
              ],
            )
          ],
        ),
      ),
    );
  }
}
