class ChatRoom{
  String? id;
  List? members;
  String? createdAt;
  String? lastMessage;
  String? lastMessageTime;


  ChatRoom({
    required this.id,
    required this.createdAt,
    required this.members,
    required this.lastMessageTime,
    required this.lastMessage,
  });

  factory ChatRoom.fromJson(Map<String , dynamic> json){
    return ChatRoom(
        id: json['id'] ?? "",
      members: json['members'] ?? [],
        createdAt: json['created_at'] ?? "",
      lastMessage: json['last_message'] ?? "",
      lastMessageTime: json['last_message_time'] ?? "",
    );
  }

  Map<String , dynamic> toJson(){
    return {
      'id' : id,
      'created_at' : createdAt,
      'members' : members,
      'last_message' : lastMessage,
      'last_message_time' : lastMessageTime,
    };
  }

}