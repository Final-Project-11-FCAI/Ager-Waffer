import 'package:ager_waffer/Features/Chat/data/models/message_model.dart';
import 'package:ager_waffer/Features/Chat/data/models/room_models.dart';
import 'package:ager_waffer/Features/Chat/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FireData {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? get myUid => FirebaseAuth.instance.currentUser?.uid;
  String now = DateTime.now().millisecondsSinceEpoch.toString();

  Future createRoom(String email) async {
    print("START createRoom");

    if (myUid == null) {
      print("ERROR: myUid is null");
      return;
    }

    QuerySnapshot userEmail = await firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    print("Users found: ${userEmail.docs.length}");

    if (userEmail.docs.isEmpty) {
      print("ERROR: No user with this email");
      return;
    }

    String userId = userEmail.docs.first.id;

    List<String> members = [myUid!, userId]..sort();

    String roomId = members.join("_");

    DocumentSnapshot room =
    await firestore.collection('rooms').doc(roomId).get();

    print("Room exists: ${room.exists}");

    if (!room.exists) {
      print("Creating room...");

      await firestore.collection('rooms').doc(roomId).set({
        "id": roomId,
        "members": members,
        "createdAt": DateTime.now().millisecondsSinceEpoch,
        "lastMessage": '',
        "lastMessageTime": DateTime.now().millisecondsSinceEpoch,
      });

      print("Room created successfully ✅");
    } else {
      print("Room already exists ⚠️");
    }

    print("END createRoom");
  }

  // Future createRoom(String email) async {
  //   if (myUid == null) return;
  //   QuerySnapshot userEmail = await firestore
  //       .collection('users')
  //       .where('email', isEqualTo: email)
  //       .get();
  //
  //   if (userEmail.docs.isNotEmpty) {
  //     String userId = userEmail.docs.first.id;
  //     List<String> members = [myUid!, userId]..sort((a, b) => a.compareTo(b));
  //
  //     QuerySnapshot roomExist = await firestore
  //         .collection('rooms')
  //         .where('members', isEqualTo: members)
  //         .get();
  //
  //     if (roomExist.docs.isEmpty) {
  //       ChatRoom chatRoom = ChatRoom(
  //         id: members.toString(),
  //         createdAt: DateTime.now().toString(),
  //         lastMessageTime: DateTime.now().toString(),
  //         lastMessage: '',
  //         members: members,
  //       );
  //
  //       await firestore
  //           .collection('rooms')
  //           .doc(members.toString())
  //           .set(chatRoom.toJson());
  //     }
  //   }
  // }

  Future sendGMessage(String msg, String groupId, {String? type}) async {
    if (myUid == null) return;
    String msgId = Uuid().v1();
    Message message = Message(
      id: msgId,
      toId: '',
      fromId: myUid,
      msg: msg,
      type: type ?? 'text',
      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
      read: null,
    );
    await firestore
        .collection('groups')
        .doc(groupId)
        .collection('messages')
        .doc(msgId)
        .set(message.toJson());

    await firestore.collection('groups').doc(groupId).update({
      'last_message': type ?? msg,
      'last_message_time': DateTime.now().millisecondsSinceEpoch.toString(),
    });
  }

  Future sendMessage(
    String uid,
    String msg,
    String roomId,
    ChatUser chatUser,
    BuildContext context, {
    String? type,
  }) async {
    if (myUid == null) return;
    String msgId = Uuid().v1();
    Message message = Message(
      id: msgId,
      toId: uid,
      fromId: myUid,
      msg: msg,
      type: type ?? 'text',
      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
      read: null,
    );
    await firestore
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .doc(msgId)
        .set(message.toJson());
    // .then((value) => sendNotification(chatUser: chatUser, context: context, msg: type ?? msg));

    await firestore.collection('rooms').doc(roomId).update({
      'last_message': type ?? msg,
      'last_message_time': DateTime.now().millisecondsSinceEpoch.toString(),
    });
  }

  Future readMessage(String roomId, String msgId) async {
    if (roomId.isEmpty || msgId.isEmpty) return;
    await firestore
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .doc(msgId)
        .update({'read': DateTime.now().millisecondsSinceEpoch});
  }

  deleteMsg(String roomId, List<String> msgs) async {
    for (var element in msgs) {
      await firestore
          .collection('rooms')
          .doc(roomId)
          .collection('messages')
          .doc(element)
          .delete();
    }
  }

  Future editGroup(String gId, String name, List members) async {
    await firestore.collection('groups').doc(gId).update({
      'name': name,
      'members': FieldValue.arrayUnion(members),
    });
  }

  Future removeMember(String gId, String memberId) async {
    await firestore.collection('groups').doc(gId).update({
      'members': FieldValue.arrayRemove([memberId]),
    });
  }

  Future promptAdmin(String gId, String memberId) async {
    await firestore.collection('groups').doc(gId).update({
      'admins_id': FieldValue.arrayUnion([memberId]),
    });
  }

  Future removeAdmin(String gId, String memberId) async {
    await firestore.collection('groups').doc(gId).update({
      'admins_id': FieldValue.arrayRemove([memberId]),
    });
  }

  Future editProfile(String name, String about) async {
    await firestore.collection('users').doc(myUid).update({
      'name': name,
      'about': about,
    });
  }

  // sendNotification(
  //     {required ChatUser chatUser, required BuildContext context, required String msg}) async {
  //   final header = {
  //     'Content-Type' : 'application/json',
  //     'Authorization' :
  //         'key=eBubFp28SPSGkFNg5PUyQw:APA91bGhEOdd-Oh1YixJpBdNGFv4BWFmxlGlkyk7JPkAMUtFN7tnseXv-L8Uh_kKvyMWcmzsIWTXoSMG_FLNyQiW2ulbyOv1pK106Zz_Mk-oQ13Hhs4Sb8M'
  //   };
  //   final body = {
  //     'to': chatUser.pushToken,
  //     "notification": {
  //       "title": Provider.of<ProviderApp>(context , listen: false).me!.name,
  //       "body": msg,
  //     }
  //   };
  //   // final req = await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //   final req = await http.post(Uri.parse('https://fcm.googleapis.com/v1/projects/chat-material3-bd4c6/messages:send'),
  //       body: jsonEncode(body), headers: header);
  //   print("Status Code : ${req.statusCode}");
  // }
}
