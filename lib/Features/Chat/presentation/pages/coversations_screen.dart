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
  TextEditingController emailCon = TextEditingController();


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
                      controller: emailCon,
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
                          if (emailCon.text.isNotEmpty) {
                            FireData().createRoom(emailCon.text).then((value) {
                              print('the room is created');
                              setState(() {
                                emailCon.text = '';
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
                    .where('members',
                     arrayContains: FirebaseAuth.instance.currentUser!.uid)
                    //arrayContains: currentUser.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<ChatRoom> items = snapshot.data!.docs
                        .map((e) => ChatRoom.fromJson(e.data()))
                        .toList()..sort((a, b) => b.lastMessageTime!.compareTo(a.lastMessageTime!),);
                    return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return ChatCard(item: items[index],);
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
