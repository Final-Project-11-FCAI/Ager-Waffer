import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  String? id;
  String? toId;
  String? fromId;
  String? msg;
  String? type;
  String? createdAt;
  DateTime? read;

  Message({
    required this.id,
    required this.toId,
    required this.fromId,
    required this.msg,
    required this.type,
    required this.createdAt,
    required this.read,
  });

  factory Message.fromJson(Map<String , dynamic> json){
    DateTime? readTime;
    final readValue = json['read'];

    if (readValue is Timestamp) {
      readTime = readValue.toDate();
    } else if (readValue is int) {
      readTime = DateTime.fromMillisecondsSinceEpoch(readValue);
    } else if (readValue is String) {
      if (RegExp(r'^\d+$').hasMatch(readValue)) {
        readTime = DateTime.fromMillisecondsSinceEpoch(int.parse(readValue));
      } else {
        // Try normal DateTime parse; ignore failures
        try {
          readTime = DateTime.parse(readValue);
        } catch (_) {
          readTime = null;
        }
      }
    }

    return Message(
      id: json['id'] ?? "",
      toId: json['to_id'],
      fromId: json['from_id'],
      msg: json['msg'],
      type: json['type'],
      createdAt: json['created_at']?.toString(),
      read: readTime,
    );
  }

  Map<String , dynamic> toJson(){
    return {
      'id' : id,
      'to_id' : toId,
      'from_id' : fromId,
      'msg' : msg,
      'type' : type,
      'created_at' : createdAt,
      'read' : read,
    };
  }

}