class ChatRoom {
  String? id;
  List<String>? members;
  int? createdAt;
  String? lastMessage;
  int? lastMessageTime;

  ChatRoom({
    this.id,
    this.createdAt,
    this.members,
    this.lastMessageTime,
    this.lastMessage,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      id: json['id']?.toString(),
      members: List<String>.from(json['members'] ?? []),

      createdAt: json['created_at'] is int
          ? json['created_at']
          : int.tryParse(json['created_at']?.toString() ?? '0'),

      lastMessage: json['last_message']?.toString(),

      lastMessageTime: json['last_message_time'] is int
          ? json['last_message_time']
          : int.tryParse(json['last_message_time']?.toString() ?? '0'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'members': members,
      'created_at': createdAt,
      'last_message': lastMessage,
      'last_message_time': lastMessageTime,
    };
  }
}