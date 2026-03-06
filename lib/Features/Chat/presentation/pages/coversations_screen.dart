import 'package:ager_waffer/Features/Chat/data/models/firebase/fire_database.dart';
import 'package:ager_waffer/Features/Chat/data/models/room_models.dart';
import 'package:ager_waffer/Features/Chat/presentation/widgets/chat_card.dart';
import 'package:ager_waffer/Features/Chat/presentation/widgets/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ConversationsScreen extends StatefulWidget {
  const ConversationsScreen({super.key});

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  TextEditingController emailController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _setupFCM();
  }

  void _setupFCM() async {
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission();

    String? token = await FirebaseMessaging.instance.getToken();
    print("🔑 FCM Token: $token");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📥 Foreground message: ${message.notification?.title}");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("🚀 App opened from notification");
    });
  }



  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return const Scaffold(
        body: Center(
          child: Text('يُرجى تسجيل الدخول لعرض المحادثات'),
        ),
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'chat_fab',
        onPressed: () {
          showBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Enter Friend Email",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Spacer(),
                        IconButton.filled(
                          onPressed: () {},
                          icon: Icon(Icons.scanner_outlined),
                        )
                      ],
                    ),
                    CustomField(
                      controller: emailController,
                      icon: Icons.dashboard_customize_outlined,
                      lable: "Email",
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer),
                        onPressed: () {
                          if (emailController.text.isNotEmpty) {
                            FireData().createRoom(emailController.text).then((value) {
                              print("ROOM FUNCTION FINISHED");
                              setState(() {
                                emailController.text = '';
                              });
                              Navigator.pop(context);
                            });
                          }
                        },
                        child: Center(
                          child: Text("Create Chat"),
                        ))
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.message_outlined),
      ),
      appBar: AppBar(
        title: const Text("Chats"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('rooms')
                    .where('members', arrayContains: currentUser.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No Chats Yet"));
                  }

                  final List<ChatRoom> items = snapshot.data!.docs
                      .map((e) => ChatRoom.fromJson({
                            ...e.data(),
                            'id': e.id, // ensure non-empty id
                          }))
                      .toList()
                      .cast<ChatRoom>();

                  // Sort by lastMessageTime (newest first)
                  items.sort(
                    (ChatRoom a, ChatRoom b) =>
                        (b.lastMessageTime ?? 0).compareTo(a.lastMessageTime ?? 0),
                  );

                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ChatCard(item: items[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
