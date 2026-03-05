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
    print("json['created_at'] : ${json['created_at']} , ${json['created_at'].runtimeType}" );
    print("json : $json");
    return Message(
        id: json['id'] ?? "",
        toId: json['to_id'],
        fromId: json['from_id'],
        msg: json['msg'],
        type: json['type'],
        createdAt: json['created_at'].toString(),
    read: json['read'] != null ? (json['read'] as Timestamp).toDate() : null);
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